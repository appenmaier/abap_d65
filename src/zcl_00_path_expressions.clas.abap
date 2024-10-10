CLASS zcl_00_path_expressions DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_00_path_expressions IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*    SELECT FROM Z00_C_EmployeeQuery( p_targetcurrencycode = 'EUR' )
*      FIELDS employeeid,
*             firstname,
*             lastname,
*             departmentid,
*             DepartmentDescription,
*             AssistantName,
*             \_Department\_Head-LastName AS HeadName,
*             AnnualSalaryConverted,
*             CurrencyCode
*      INTO TABLE @FINAL(result).
*
*    out->write( result ).

    DATA department TYPE /lrn/depment_rel.
    SELECT SINGLE FROM /lrn/depment_rel FIELDS * INTO @department.

    department-id = '0000000003'.
    department-description = 'Development'.

    INSERT /lrn/depment_rel FROM @department.

  ENDMETHOD.
ENDCLASS.
