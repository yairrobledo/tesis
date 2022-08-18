view: Park_Derive_Table {
  derived_table: {
    sql: SELECT t.park_name, extract(year from (t.established)) established
FROM `national_parks.parks` t
where {% condition experiment %} park.parks_name {% endcondition %};;
  }
  parameter: experiment_name {
    type: unquoted
  }

}
