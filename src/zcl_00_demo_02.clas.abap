CLASS zcl_00_demo_02 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_00_demo_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM Z00_C_Flight( p_carrierid = 'LH' )
      FIELDS *
*      WHERE CarrierId = 'LH'
      INTO TABLE @FINAL(flights).

    out->write( flights ).
  ENDMETHOD.
ENDCLASS.
