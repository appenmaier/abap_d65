@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Extended'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity Z00_C_FlightExtended
  as select from Z00_I_ConnWithFligthAndAirport
{
  key CarrierId,
  key ConnectionId,
  key _Flights.flight_date,
      AirportFromId,
      AirportToId,
      DepartureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      
      /* Associations */
      _ArrivalAirport,
      _DepartureAirport

}
