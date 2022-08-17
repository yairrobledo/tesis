view: First {
  derived_table: {
    explore_source: parks {
    }
    sql: SELECT t.park_name, extract(year from (t.established)) established
    FROM `national_parks.parks` t
    where t.established=(select min(s.established) from  `national_parks.parks` s);;
  }

  dimension: park_name {
    primary_key: yes
    label: "Park"
    description: ""
  }
  dimension: established {
  }
}
