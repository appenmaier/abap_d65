@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 3: Built-In Functions'
define view entity Z00_I_Demo03
  as select from /dmo/connection
{
  /* String Functions */
  carrier_id,
  connection_id,
  concat_with_space(carrier_id, connection_id, 1) as FlightConnection,
  length('  X')                                   as SSX,
  length('X  ')                                   as XSS,
  length('   ')                                   as SSS,

  /* Unit/Currency Conversion */
  distance                                        as OldDistance,
  distance_unit                                   as OldDistanceUnit,
  @Semantics.quantity.unitOfMeasure: 'NewDistanceUnit'
  unit_conversion(
    quantity => distance,
    source_unit => distance_unit,
    target_unit => cast('MI' as abap.unit) )      as NewDistance,
  cast('MI' as abap.unit)                         as NewDistanceUnit,

  /* Date/Time Functions */
  dats_add_days($session.user_date, 40, 'FAIL')   as NewDate

}
