view: visit_ranking {
      derived_table: {
        sql:

       SELECT

    parks.State  AS park_state,
    parks.park_name  AS park_name,
    parks.est_annual_visitors  AS parks_est_annual_visitors,
    RANK() OVER(ORDER BY  parks.est_annual_visitors  DESC) as rank
FROM `national_parks.parks`
     AS parks
     group by 1,2,3
ORDER BY 4 asc;;

            # SELECT brand, count(*) as count,
            # FROM order_items LEFT JOIN inventory_items on order_items.inventory_item_id=inventory_items.id
            # LEFT JOIN products ON inventory_items.product_id = products.id
            # GROUP BY 1
      }
  drill_fields: [park_name]


      dimension: park_name {
        type: string
        primary_key: yes
        sql: ${TABLE}.park_name ;;
        link: {
          label: "Park Details"
          url:"https://productday.dev.looker.com/dashboards/938"}
        # https://productday.dev.looker.com/dashboards/938
        #
      }

  dimension: state {
    type: string
    sql: ${TABLE}.park_state ;;
  }
  dimension: rank_raw {
    type: number
    sql: ${TABLE}.rank ;;
  }
measure: avg_visitors {
  type: average
  sql: ${TABLE}.parks_est_annual_visitors ;;
  value_format: "0.00,,\" M\""
}

  # filter: rank_date_range {
  #   type: date
  #   description: "Select a range within which you are ranking the ordering of countries by metric selection. E.g. the rank of countries who had the top 10 highest revenue in May"
  # }
  parameter: ranking {
    type: number
  }
  dimension: rank {
    type: string
    sql: CASE WHEN ${rank_raw} <= {% parameter ranking %} THEN CAST(${rank_raw} AS STRING) ELSE 'Other' END;;
  }

  dimension: rank_and_park {
    type: string
    sql: CASE WHEN ${rank} = 'Other' THEN 'Other' ELSE ${park_name} END;;

  }

  dimension: rank_and_park_bool {
    type: yesno
    sql:${rank} <> 'Other';;
  }
  # dimension: rank_and_park {
  #   type: string
  #   sql: CASE WHEN ${rank} = 'Other' THEN 'Other' ELSE ${rank} || '-' || ${park_name} END;;
  # }

}


  # dimension: country_code {
  #   primary_key: yes
  #   hidden: yes
  #   type: string
  #   sql: ${TABLE}.country_code ;;
  # }

  # parameter: country_name_criteria {
  #   label: "Ranking Criteria"
  #   description: "Specify which metric to order the ranking by"
  #   type: unquoted
  #   default_value: "totalGrossRevenue"
  #   allowed_value: {
  #     label: "Total Gross Revenue"
  #     value: "totalGrossRevenue"
  #   }
  #   allowed_value: {
  #     label: "Average Gross Revenue"
  #     value: "averageGrossRevenue"
  #   }
  #   allowed_value: {
  #     label: "Visitor Count"
  #     value: "visitorCount"
  #   }
  # }



  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }


# view: visit_ranking {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
