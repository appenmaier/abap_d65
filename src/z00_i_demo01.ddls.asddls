@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 1: Cases and Literals'
define view entity Z00_I_Demo01
  as select from /dmo/flight
{
  /* Literals */
  'Hello World' as String1,
  42            as Int1,
  798.44        as Fltp1,
  /* Cases */
  flight_date,
  case when flight_date >= '20240101' and flight_date < '20250101' then '2024'
       when flight_date >= '20250101' and flight_date < '20260101' then '2025'
       else '0000'
  end           as FlightYear,
  currency_code,
  case currency_code
    when 'SGD' then 'Singapur Dollar'
    when 'EUR' then 'Euro'
    when 'JPY' then 'Yen'
    else 'unwichtige Währung'
  end           as CurrencyCodeText

}
where connection_id > '0300'
