CLASS zcl_00_structure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

* Task 1: Simple Structure
**********************************************************************
*    TYPES:
*      BEGIN OF st_address,
*        street      TYPE /dmo/street,
*        postal_code TYPE /dmo/postal_code,
*        city        TYPE /dmo/city,
*        country     TYPE land1,
*      END OF st_address.

* Task 2: Nested Structure
**********************************************************************
*    TYPES:
*      BEGIN OF st_name,
*        first_name TYPE /dmo/first_name,
*        last_name  TYPE /dmo/last_name,
*      END OF st_name.
*
*    TYPES: BEGIN OF st_person,
*             name    TYPE st_name,
*             address TYPE z00_address,
*           END OF st_person.


*Task 3: Named Includes
**********************************************************************
*    TYPES BEGIN OF st_person_inc.
*    INCLUDE TYPE z00_name    AS name.
*    INCLUDE TYPE z00_address AS address.
*    TYPES END OF st_person_inc.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00_structure IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Task 1
**********************************************************************
    DATA address TYPE z00_address.

    address-street      = 'Dietmar-Hopp-Allee 16'.
    address-postal_code = '69190'.
    address-city        = 'Walldorf'.
    address-country     = 'DE'.

* Task 2
**********************************************************************
    DATA person TYPE z00_person.

    person-name-first_name     = 'Dictionary'.
    person-name-last_name      = 'ABAP'.
    person-address-street      = 'Dietmar-Hopp-Allee 16'.
    person-address-postal_code = '69190'.
    person-address-city        = 'Walldorf'.
    person-address-country     = 'DE'.

* Task 2
**********************************************************************
    DATA person2 TYPE z00_person_inc.

    person2-name-first_name     = 'Dictionary'.
    person2-name-last_name      = 'ABAP'.
    person2-address-street      = 'Dietmar-Hopp-Allee 16'.
    person2-address-postal_code = '69190'.
    person2-address-city        = 'Walldorf'.
    person2-address-country     = 'DE'.
* or -------------------------------------------------------
    person2-first_name  = 'Dictionary'.
    person2-last_name   = 'ABAP'.
    person2-street      = 'Dietmar-Hopp-Allee 16'.
    person2-postal_code = '69190'.
    person2-city        = 'Walldorf'.
    person2-country     = 'DE'.

  ENDMETHOD.
ENDCLASS.
