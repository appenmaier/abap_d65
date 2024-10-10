@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Query'
define view entity Z00_C_FlightQuery
  as select from /dmo/flight
{
  key carrier_id,
  key connection_id,
      count(*)                              as NumberOfFlights,
      count(distinct plane_type_id)         as NumberOfDifferentPlaneTypeIds,
      sum(seats_occupied)                   as TotalNumberOfOccupiedSeats,
      @Semantics.amount.currencyCode: 'currency_code'
      avg(price as abap.curr(16,2))         as AverageFlightPrice,
      currency_code,
      avg(seats_occupied as abap.dec(16,2)) as AverageNumberOfOccupiedSeats,
      min(seats_occupied)                   as MininumNumberOfOccupiedSeats,
      max(seats_occupied)                   as MaximumNumberOfOccupiedSeats,
      sum(case when seats_occupied / seats_max < 0.8 then 0
               else 1 end)                  as NumberOfAlmostBookedFlights
}
group by
  currency_code,
  carrier_id,
  connection_id
having
  avg(price as abap.curr(16,2)) > 5000
