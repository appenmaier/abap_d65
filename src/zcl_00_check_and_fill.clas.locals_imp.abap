*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_table DEFINITION.

  PUBLIC SECTION.
    DATA name  TYPE tabname READ-ONLY.

    METHODS constructor
      IMPORTING
        i_name   TYPE tabname
        i_source TYPE tabname
      RAISING
        cx_abap_not_a_table.
    METHODS
      compare
        RETURNING
          VALUE(r_output) TYPE string_table.
    METHODS
      copy
        RAISING
          cx_root .

  PROTECTED SECTION.

  PRIVATE SECTION.


    DATA source TYPE tabname.

    CLASS-METHODS is_table
      IMPORTING
        i_name TYPE tabname
      RAISING
        cx_abap_not_a_table.


ENDCLASS.

CLASS lcl_table IMPLEMENTATION.

  METHOD constructor.

    is_table( i_name ).
    name = i_name.

    is_table( i_source ).
    source = i_source.

  ENDMETHOD.

  METHOD compare.

    DATA(components)   = CAST cl_abap_structdescr(
                              cl_abap_typedescr=>describe_by_name( name )
                         )->components.

    DATA(components_t) = CAST cl_abap_structdescr(
                             cl_abap_typedescr=>describe_by_name( source )
                          )->components.

     data(count) = lines( components ).
     data(count_t) = lines(  components_t ).

         if count <> count_t.
          APPEND |Table { name } has { count } fields ( expected: { count_t } ) |
           TO r_output.
    else.

    LOOP AT components_t ASSIGNING FIELD-SYMBOL(<compt>).

      ASSIGN components[ sy-tabix ] TO FIELD-SYMBOL(<comp>).
      IF <comp>-type_kind <> <compt>-type_kind.
        APPEND |Column { sy-tabix WIDTH = 2 align = right }: Wrong basic type ( { <comp>-type_kind } instead of { <compt>-type_kind } )|
            TO r_output.

      ELSEIF <comp>-length <> <compt>-length.
        APPEND |Column { sy-tabix WIDTH = 2 align = right }: Wrong length ( { <comp>-length } instead of { <compt>-length } )|
            TO r_output.

      ELSEIF <comp>-decimals <> <compt>-decimals.
        APPEND |Column { sy-tabix WIDTH = 2 align = right }: Wrong number of decimals!|
           TO r_output.

      ENDIF.

    ENDLOOP.

endif.
  ENDMETHOD.

  METHOD copy.

    DATA r_source TYPE REF TO data.
    DATA r_target TYPE REF TO data.

    CREATE DATA r_source TYPE TABLE OF (source).
    CREATE DATA r_target TYPE TABLE OF (name).

    ASSIGN  r_source->* TO FIELD-SYMBOL(<source>).
    ASSIGN  r_target->* TO FIELD-SYMBOL(<target>).

    SELECT
      FROM (source)
    FIELDS *
      INTO TABLE @<source>.

    LOOP AT <source> ASSIGNING FIELD-SYMBOL(<source_row>).

      INSERT INITIAL LINE INTO TABLE <target> ASSIGNING FIELD-SYMBOL(<target_row>).

      DO.
        ASSIGN COMPONENT sy-index OF STRUCTURE <source_row> TO FIELD-SYMBOL(<source_field>).
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.

        ASSIGN COMPONENT sy-index OF STRUCTURE <target_row> TO FIELD-SYMBOL(<target_field>).

        <target_field> = <source_field>.

      ENDDO.
    ENDLOOP.

    MODIFY (name) FROM TABLE @<target>.

  ENDMETHOD.


  METHOD is_table.

* XCO alternative
    DATA(lo_name_filter) = xco_cp_abap_repository=>object_name->get_filter( xco_cp_abap_sql=>constraint->equal( i_name ) ).

    DATA(lt_objects) = xco_cp_abap_repository=>objects->tabl->database_tables->where( VALUE #(
      ( lo_name_filter )
    ) )->in( xco_cp_abap=>repository )->get( ).

    IF lt_objects IS INITIAL.
      RAISE EXCEPTION NEW cx_abap_not_a_table( value = CONV #( i_name ) ).
    ENDIF.

* RTTI Alternative

*    cl_abap_typedescr=>describe_by_name(
*      EXPORTING
*        p_name         = i_name
*      RECEIVING
*        p_descr_ref    = DATA(type)
*      EXCEPTIONS
*        type_not_found = 1
*    ).
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION NEW cx_abap_not_a_table( value = CONV #( i_name ) ).
*    ENDIF.
*
*    IF type->kind <> type->kind_struct.
*      RAISE EXCEPTION NEW cx_abap_not_a_table( value = CONV #( i_name ) ).
*    ENDIF.
*
*    IF type->is_ddic_type( ) <> cl_abap_typedescr=>true.
*      RAISE EXCEPTION NEW cx_abap_not_a_table( value = CONV #( i_name ) ).
*    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_generator DEFINITION.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ENUM t_version,
        employee_table_only,
        with_relationships,
        with_extensions,
      END OF ENUM t_version.


    METHODS constructor
      IMPORTING
        i_version       TYPE t_version
        i_employ_table  TYPE tabname
        i_depment_table TYPE tabname
        i_out           TYPE REF TO if_oo_adt_classrun_out
      RAISING
        cx_abap_not_a_table.

    METHODS
      run.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA tables TYPE TABLE OF REF TO lcl_table.

    DATA out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.

CLASS lcl_generator IMPLEMENTATION.

  METHOD constructor.

    APPEND NEW lcl_table( i_name = i_employ_table
                          i_source =  SWITCH #( i_version
                                           WHEN employee_table_only    THEN '/LRN/EMPLOY'
                                           WHEN with_relationships     THEN '/LRN/EMPLOY_REL'
                                           WHEN with_extensions        THEN '/LRN/EMPLOY_EXT' )
                         )
        TO tables.

    IF i_version = with_relationships.
      APPEND NEW lcl_table( i_name = i_depment_table
                            i_source = '/LRN/DEPMENT_REL'
                           )
          TO tables.
    ENDIF.

    me->out = i_out.

  ENDMETHOD.

  METHOD run.

    LOOP AT tables INTO DATA(table).

      DATA(log) = table->compare( ).

      IF log IS NOT INITIAL.

        out->write( data = log
                    name = |Errors in Table { table->name } | ).

      ELSE.

        out->write( |Table { table->name } is correctly defined.| ).

        TRY.
            table->copy( ).
            out->write( |Filled table { table->name }| ).
          CATCH cx_root INTO DATA(excp).
            out->write( |Error during data copy: { excp->get_text( ) } | ).
        ENDTRY.
      ENDIF.
      out->write( `--------------------------------------------------` ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
