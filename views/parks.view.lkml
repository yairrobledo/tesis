# The name of this view in Looker is "Parks"
view: parks {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `national_parks.parks`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Acres" in Explore.

  dimension: acres {
    type: number
    sql: ${TABLE}.Acres ;;
  }

  dimension: product_image {
    sql: ${park_name} ;;

  }

  # dimension: park_no_eagle {
  #   sql: ${bald_eagle}.Park ;;
  # }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_acres {
    type: sum
    sql: ${acres} ;;
  }

  measure: average_acres {
    type: average
    sql: ${acres} ;;
  }

  dimension: art {
    type: string
    sql: ${TABLE}.Art ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: est_annual_visitors {
    type: number
    sql: ${TABLE}.est_annual_visitors ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: established {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.established ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }

  dimension: park_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: park_code {
    type: string
    sql: ${TABLE}.Park_Code ;;
  }

  dimension: most_recent {
    type: yesno
    label: "Most recent Park"
    sql: DATE_DIFF( ${TABLE}.established, MAX( ${TABLE}.established), DAY) = 0 ;;
  }
  dimension_group: last_park_establishment {
    label: "Last Open Park"
    type: date_year
    timeframes: [
      year
    ]
    sql: ${TABLE}.established ;;
    convert_tz: no
  }
  measure: last{
    type: max
    sql: ${last_park_establishment};;
  }
  dimension: park_name {

    label:"Park"
    type: string
    sql: ${TABLE}.park_name;;

    html:
    {{ linked_value }}
    <a href="https://www.google.com/search?q={{ value }}" target="_new">
    <img src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Google-favicon-2015.png" height=15 width=15> </a> ;;
  }
dimension: park_image {
  type: string
  sql: ${TABLE}.art;;
  html: <img src="{{value}}" height=200 width=200/> ;;
}

dimension: eagle_image {
  type: string
  sql: ${TABLE}.art;;
  html: <img src="http://t2.gstatic.com/images?q=tbn:ANd9GcSt4LHJWgIv8jtNsIC9A162zn49SHzXqOkEwxHA7my44sYjISX_" height=200 width=200/> ;;
}
  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.State ;;
  }

  dimension: world_heritage_site {
    type: yesno
    sql: ${TABLE}.world_heritage_site ;;
  }

  measure: count {
    type: count
    drill_fields: [park_name]
  }
}
