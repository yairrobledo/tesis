# The name of this view in Looker is "Park Climate"
view: park_climate {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `national_parks.park_climate`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Avg Barometric Pressure" in Explore.


  parameter: metric_selector {
    type: string
    allowed_value: {
      label: "Avg Barometric Pressure"
      value: "avg_barometric_pressure"
    }
    allowed_value: {
      label: "Avg Cloud Cover"
      value: "avg_cloud_cover"
    }
    allowed_value: {
      label: "Avg Dry Days"
      value: "avg_dry_days"
    }
    allowed_value: {
      label: "Avg Fog Days"
      value: "avg_fog_days"
    }
    allowed_value: {
      label: "Avg Humidity"
      value: "avg_humidity"
    }
    allowed_value: {
      label: "Avg Precip Days"
      value: "avg_precip_days"
    }
    allowed_value: {
      label: "Avg Precipitation"
      value: "avg_precipitation"
    }
    # ------------------------------------------------
    allowed_value: {
      label: "Avg Snow Days"
      value: "avg_snow_days"
    }
    allowed_value: {
      label: "Avg Sun Hours"
      value: "avg_sun_hours"
    }
    allowed_value: {
      label: "Avg Tmp High"
      value: "avg_tmp_high"
    }
    allowed_value: {
      label: "Avg Tmp Low"
      value: "avg_tmp_low"
    }
    allowed_value: {
      label: "Avg UV Index"
      value: "avg_uv_index"
    }
    allowed_value: {
      label: "Avg Wind MPH"
      value: "avg_wind_mph"
    }
  }

 measure: metric {
  label_from_parameter: metric_selector
  type: number
  sql:
    CASE
      WHEN {% parameter metric_selector %} = 'avg_barometric_pressure'
        THEN ${avg_barometric_pressure}
      WHEN {% parameter metric_selector %} = 'avg_cloud_cover'
        THEN ${avg_cloud_cover}
      WHEN {% parameter metric_selector %} = 'avg_dry_days'
        THEN ${avg_dry_days}
      WHEN {% parameter metric_selector %} = 'avg_fog_days'
        THEN ${avg_fog_days}
      WHEN {% parameter metric_selector %} = 'avg_humidity'
        THEN ${avg_humidity}
      WHEN {% parameter metric_selector %} = 'avg_precip_days'
        THEN ${avg_precip_days}
      WHEN {% parameter metric_selector %} = 'avg_precipitation'
        THEN ${avg_precipitation}
        /*-----------------------*/
      WHEN {% parameter metric_selector %} = 'avg_snow_days'
        THEN ${avg_snow_days}
      WHEN {% parameter metric_selector %} = 'avg_sun_hours'
        THEN ${avg_sun_hours}
      WHEN {% parameter metric_selector %} = 'avg_tmp_high'
        THEN ${avg_tmp_high}
      WHEN {% parameter metric_selector %} = 'avg_tmp_low'
        THEN ${avg_tmp_low}
      WHEN {% parameter metric_selector %} = 'avg_uv_index'
        THEN ${avg_uv_index}
      WHEN {% parameter metric_selector %} = 'avg_wind_mph'
        THEN ${avg_wind_mph}

      ELSE NULL
    END ;;
    value_format: "0.00"
}

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_avg_barometric_pressure {
  #   type: sum
  #   sql: ${avg_barometric_pressure} ;;
  # }

  measure: avg_barometric_pressure {
    type: average
    sql: ${TABLE}.avg_barometric_pressure ;;
  }

  measure: avg_cloud_cover {
    type: average
    sql: ${TABLE}.avg_cloud_cover ;;
  }

  measure: avg_dry_days {
    type: average
    sql: ${TABLE}.avg_dry_days ;;
  }

  measure: avg_fog_days {
    type: average
    sql: ${TABLE}.avg_fog_days ;;
  }

  measure: avg_humidity {
    type: average
    sql: ${TABLE}.avg_humidity ;;
  }

  measure: avg_precip_days {
    type: average
    sql: ${TABLE}.avg_precip_days ;;
  }

  measure: avg_precipitation {
    type: average
    sql: ${TABLE}.avg_precipitation ;;
  }

  measure: avg_snow_days {
    type: average
    sql: ${TABLE}.avg_snow_days ;;
  }

  measure: avg_sun_hours {
    type: average
    sql: ${TABLE}.avg_sun_hours ;;
  }

  measure: avg_tmp_high {
    type: average
    sql: ${TABLE}.avg_tmp_high ;;
  }

  measure: avg_tmp_low {
    type: average
    sql: ${TABLE}.avg_tmp_low ;;
  }

  measure: avg_uv_index {
    type: average
    sql: ${TABLE}.avg_uv_index ;;
  }

  measure: avg_wind_mph {
    type: average
    sql: ${TABLE}.avg_wind_mph ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: park {
    type: string
    sql: ${TABLE}.park ;;
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
