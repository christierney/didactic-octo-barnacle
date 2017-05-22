.[] |
[ .times.requestBegin,
  .durations.latency,
  .durations.total, 
  .response.sizes.headers, 
  .response.sizes.body, 
  (.response.header.headers | map({(.name): .value}) | add |
    (."X-Cache-CF" | contains("Hit")) and (."X-Cache" | contains("MISS")) and (."X-Cache-Remote" | contains("MISS")?),
        (."X-Cache-Remote" | contains("HIT")?//false),
        (."X-Cache" | contains("HIT"))
  )
] |
@csv

