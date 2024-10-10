@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 2: Artithmetic Operators and Type Casts'
define view entity Z00_I_Demo02
  as select from /dmo/flight
{
  seats_max,
  seats_occupied,
  @EndUserText.label: 'Free Seats'
  @EndUserText.quickInfo: 'Free Seats'
  seats_max - seats_occupied             as SeatsFree,
  seats_occupied + 1                     as SeatsOccupiedPlus1,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  price,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  price * 2                              as DoublePrice,
  cast(price as abap.fltp) * 1.4         as NewPrice,
  seats_occupied / seats_max             as Ratio,
  division(seats_occupied, seats_max, 2) as Ratio2,
  div(seats_max, seats_occupied)         as Div,
  mod(seats_max, seats_occupied)         as Mod,
  ' LH'                                  as CarrierId,
  cast(' LH' as /dmo/carrier_id)         as CarrierId2,
  cast('EUR' as abap.cuky)               as CurrencyCode
}
