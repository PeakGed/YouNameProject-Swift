GET /api/v4/me/profile HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzNDBjYWI2MWM0YjU2YWUwOWRjNzhhNGI3YmNiZDZkMyIsImlhdCI6MTc0NjkzNTM5MywiZXhwIjoxNzQ2OTM2MjkzLCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.Afwc16-J4rv0sen6KgefVExpUkcWYqGbMwucDHRxGms

json Response:
{
    "id": 38,
    "email": "test1@email.com",
    "first_name": "John2",
    "last_name": "Doe2",
    "phone_number": "1234567890",
    "role": "ROLE_SUPPORT_SUPER_ADMIN",
    "id_card": "1232323232333",
    "logo_image": null,
    "sign_signature_image": null,
    "verified_at": null,
    "password_changed_at": "2023-11-28T06:11:43.011+07:00",
    "created_at": "2016-12-28T20:54:08.650+07:00",
    "updated_at": "2025-02-26T05:35:58.313+07:00",
    "auth_providers": [],
    "staff_id": null,
    "images": [],
    "staff": null
}

PUT /api/v4/me HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer <your_token_here>

{
  "first_name": "<string>",
  "last_name": "<string>",
  "phone_number": "<string>",
  "pin_code": "<string>",
  "id_card": "<string>",
  "line_access_token": "<string>",
  "notification_language": "th"
}

POST /api/v4/me/change-email HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIwZmU2MGM0ZTk1ZjAyZDk5MjkyM2QzOWY0NzgyNWQ5OSIsImlhdCI6MTc0Njk0NzMxMCwiZXhwIjoxNzQ2OTQ4MjEwLCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.B5kbd5NAyLWUobN5aMRl5Kkx66gY1iatZ1xuAXquZvg
Content-Length: 88

{
  "current_password": "<string>",
  "new_email": "<string>",
  "new_email_confirmation": "<string>"
}

PUT /api/v4/me/change-password HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIwZmU2MGM0ZTk1ZjAyZDk5MjkyM2QzOWY0NzgyNWQ5OSIsImlhdCI6MTc0Njk0NzMxMCwiZXhwIjoxNzQ2OTQ4MjEwLCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.B5kbd5NAyLWUobN5aMRl5Kkx66gY1iatZ1xuAXquZvg
Content-Length: 94

{
  "current_password": "<string>",
  "new_password": "<string>",
  "new_password_confirmation": "<string>"
}


POST /api/v4/me/<integer>/verification HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIwZmU2MGM0ZTk1ZjAyZDk5MjkyM2QzOWY0NzgyNWQ5OSIsImlhdCI6MTc0Njk0NzMxMCwiZXhwIjoxNzQ2OTQ4MjEwLCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.B5kbd5NAyLWUobN5aMRl5Kkx66gY1iatZ1xuAXquZvg
Content-Length: 29

{
    "pin_code" : "12345" 
}


PUT /api/v4/me/notification-settings HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiJmZjMxODQwYjRlNWJlMmI5MzMyYTdjMzU3ZWRlMGQ1MiIsImlhdCI6MTc0Njk0OTY4MSwiZXhwIjoxNzQ2OTUwNTgxLCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.Z1N-YZ0XcRYnn7Sa4N_VWvWeVG-RH-EQfcMXJZxtVYA
Content-Length: 730

{
  "new_cm_booking": true,
  "cm_booking_was_updated": true,
  "cm_booking_was_cancelled": true,
  "new_hms_reservation": true,
  "hms_reservation_was_updated": true,
  "hms_reservation_was_cancelled": true,
  "admin_broadcast_message": true,
  "system_broadcast_message": true,
  "operator_broadcast_message": true,
  "line_new_cm_booking": true,
  "line_cm_booking_was_updated": true,
  "line_cm_booking_was_cancelled": true,
  "line_new_hms_reservation": true,
  "line_hms_reservation_was_updated": true,
  "line_hms_reservation_was_cancelled": true,
  "line_admin_broadcast_message": true,
  "line_system_broadcast_message": true,
  "line_operator_broadcast_message": true  
}

GET /api/v4/me/notification-settings HTTP/1.1
Host: 157.230.37.164
Authorization: ••••••

GET /api/v4/me/devices HTTP/1.1
Host: 157.230.37.164
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4

json Response:
[
  {
    "id": 12,
    "uuid": "BA56A5D2-8EC6-466A-8F95-BDD6148F5336",
    "token": "4fdb1a52ff9718dee6236cd7fe54a1e9ac9b7a7198457dab7ee730571f99efac",
    "user_id": 38,
    "created_at": "2021-04-29T22:05:33.072+07:00",
    "updated_at": "2021-04-29T22:05:33.072+07:00"
}
]

##### Email Login #####

POST /api/v4/me/email-login/resend-code HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4
Content-Length: 17

{
  "code": "<string>"
}

POST /api/v4/me/email-login/link HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4
Content-Length: 69

{
  "code": "<string>",
  "password": "<string>",
  "confirm_password": "<string>"
}

POST /api/v4/me/email-login/send-code HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4
Content-Length: 18

{
  "email": "<string>"
}

##### Apple Login #####

POST /api/v4/me/apple-login/link HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4
Content-Length: 17

{
  "code": "<string>"
}

POST /api/v4/me/apple-login/unlink HTTP/1.1
Host: 157.230.37.164
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiI1Y2QyN2I2MTljMjYzMTEwZTNhYTg0ZjM5NGJmZmYyMCIsImlhdCI6MTc0Njk1MDM5OSwiZXhwIjoxNzQ2OTUxMjk5LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.GxstF3B1Wn0iwxQ6MVZqqEApiTZs-OxWwhMevioFim4
Content-Length: 51

{
  "password": "<string>",
  "confirm_password": "<string>"
}

