CLASS zcl_00_demo_01 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_00_demo_01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Variable
    DATA departure_airport_id TYPE c LENGTH 3. " local definition
    DATA departure_airport_id2 TYPE z00_departure_airport_id. " data element

    " Structure
    TYPES: BEGIN OF st_connection,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
           END OF ST_connection.

    DATA connection TYPE st_connection. " local definition
    DATA connection2 TYPE z00_connection. " Structure Type

    connection2-administrative_data-local_last_changed_by = sy-uname.
    connection2-created_by = sy-uname.

    " Internal Table
    TYPES tt_connections TYPE TABLE OF st_connection. " TYPE STANDARD TABLE OF st_connection WITH NON-UNIQUE KEY ...

    DATA connections TYPE tt_connections. " local definition
    DATA connections2 TYPE z00_connections. " Table Type

  ENDMETHOD.
ENDCLASS.
