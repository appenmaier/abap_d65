@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #B,
  sizeCategory: #S,
  dataClass: #MASTER
}
//@ObjectModel.usageType.serviceQuality: #B
//@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.usageType.dataClass: #MASTER
define view entity Z00_R_Flight
  as select from /dmo/flight
{
      @EndUserText.label: 'Carrier ID'
      @EndUserText.quickInfo: 'Carrier ID'
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeId,
      seats_max      as SeatsMax,
      seats_occupied as SeatsOccupied
}
