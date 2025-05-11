POST /api/v4/folios HTTP/1.1
Host: 157.230.37.164
Content-Type: application/x-www-form-urlencoded
Accept: application/json
Authorization: ••••••
Content-Length: 135

hotel_id=%3Cinteger%3E&name=%3Cstring%3E&amount=%3Cfloat%3E&description=%3Cstring%3E&category_id=%3Cinteger%3E&amount_vat_option=no_vat

POST /api/v4/folios HTTP/1.1
Host: 157.230.37.164
Content-Type: application/x-www-form-urlencoded
Accept: application/json
Authorization: ••••••
Content-Length: 135

hotel_id=%3Cinteger%3E&name=%3Cstring%3E&amount=%3Cfloat%3E&description=%3Cstring%3E&category_id=%3Cinteger%3E&amount_vat_option=no_vat

DELETE /api/v4/folios/<integer> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzMDVjOThiY2JiZTUxMWI5NzVlZWUxMzNlOWI3OWRlYSIsImlhdCI6MTc0Njg0MjA2NSwiZXhwIjoxNzQ2ODQyOTY1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.gR1-QUZpAew68Mc_xBpxuk0Xu0K8BBmWw2XNEbY6DmU


PUT /api/v4/folios/<integer> HTTP/1.1
Host: 157.230.37.164
Content-Type: application/x-www-form-urlencoded
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzMDVjOThiY2JiZTUxMWI5NzVlZWUxMzNlOWI3OWRlYSIsImlhdCI6MTc0Njg0MjA2NSwiZXhwIjoxNzQ2ODQyOTY1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.gR1-QUZpAew68Mc_xBpxuk0Xu0K8BBmWw2XNEbY6DmU
Content-Length: 135

name=%3Cstring%3E&amount=%3Cfloat%3E&description=%3Cstring%3E&status=available&category_id=%3Cinteger%3E&amount_vat_option=excluded_vat

GET /api/v4/folios/<integer> HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzMDVjOThiY2JiZTUxMWI5NzVlZWUxMzNlOWI3OWRlYSIsImlhdCI6MTc0Njg0MjA2NSwiZXhwIjoxNzQ2ODQyOTY1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.gR1-QUZpAew68Mc_xBpxuk0Xu0K8BBmWw2XNEbY6DmU