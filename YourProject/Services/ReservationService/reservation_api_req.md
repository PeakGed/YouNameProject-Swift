##### Fetch Reservations By #####

GET /api/v4/reservations/flags?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&flags=flag_a,flag_b&hotel_id=<integer> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=105&status=checked_out HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/guest?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=<integer>&guest_id=<integer> HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/company?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=<integer>&company_id=<integer> HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/period?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=<integer>&start_at=<date>&end_at=<date>&status=checked_out HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/created_at?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=<integer>&start_at=2025-04-26T20:20:00+07:00&end_at=2025-04-27T20:20:00+07:00 HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>


GET /api/v4/reservations/tags?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&tags=tag_a,tag_b&hotel_id=<integer> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/keyword?page=1&per_page=20&sorted_by=ID&sorted_order=ASC&hotel_id=<integer>&keyword=<string> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

GET /api/v4/reservations/batch_ids?ids=1,2&hotel_id=<integer> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Paginator<Reservations>

##### Fetch Reservation By #####

GET /api/v4/reservations/uid?uid=<string>&hotel_id=<integer> HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Reservation

GET /api/v4/reservations/<integer> HTTP/1.1
Host: 157.230.37.164
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA

response as swift struct
Reservation

##### Reservation #####

POST /api/v4/reservations HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI4ZjJjNmQ2MjNlOWNiNjk5YzAxYmU1ZjU1ZjEyZjQ1ZCIsImlhdCI6MTc0Njk1NTUzOSwiZXhwIjoxNzQ2OTU2NDM5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.UbZEy54vTFDblC87_7Le_2owANg_cRuwAXyaNhOsuMA
Content-Length: 1210

{
    "hotel_id": 1,
    "check_in_date": "2025-04-26",
    "check_out_date": "2025-04-27",
    "items": ["<string>", "<string>"],
    "adult_number": 2,
    "extra_adult_number": 0,
    "contact_fullname": "fullname",
    "channel_id": 1,
    "child_number": "<integer>",
    "contact_title": "<string>",
    "contact_email": "<string>",
    "contact_tel": "<string>",
    "guest_comment": "<string>",
    "ota_booking_id": "<string>",
    "sub_channel_id": "<integer>",
    "checked_in_at": "<date>",
    "checked_out_at": "<date>",
    "note": "<string>",
    "canceled_reason": "<string>",
    "document_photos": ["<string>", "<string>"],
    "data": "<json>",
    "customers": ["<string>", "<string>"],
    "markers": ["<string>", "<string>"],
    "flags": ["<string>", "<string>"],
    "tags": ["<string>", "<string>"],
    "emoji": "<string>",
    "related_reservation_id": "<integer>",
    "additional_attributes": {
        "items": [{
            "itemable_id": 1,
            "itemable_type": "Folio",
            "quantity": 2,
            "price": 1000,
            "total_amount": 2000
        }],
        "note": "Note",
        "date_issue": "2025-04-26"
    },
    "financial_record_attributes": {
        "name": "Name",
        "payment_method": "credit_card", 
        "note": "Note",
        "timestamp": "2025-04-26T13:20:00.192+0000",
        "amount": 2000
    }
}
