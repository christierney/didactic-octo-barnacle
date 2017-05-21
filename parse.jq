.[] |
[ .times.requestBegin,
  .durations.latency,
  .durations.total, 
  .response.sizes.headers, 
  .response.sizes.body, 
  (.response.header.headers | .[]? | select (.name == "X-Cache-CF") | .value),
  (.response.header.headers | .[]? | select (.name == "X-Cache") | .value ),
  (.response.header.headers | .[]? | select (.name == "X-Cache-Remote") | .value)
] |
@csv

