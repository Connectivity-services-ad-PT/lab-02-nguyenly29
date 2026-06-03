$ErrorActionPreference = "Stop"

$BaseUrl = "http://localhost:4010"
$AuthHeader = "Authorization: Bearer test-token"

Write-Host "[1/5] GET /health"
curl.exe -i "$BaseUrl/health"

Write-Host "`n---"

Write-Host "[2/5] GET /notifications/recent"
curl.exe -i "$BaseUrl/notifications/recent" -H "$AuthHeader"

Write-Host "`n---"

Write-Host "[3/5] POST /notifications"

$payload = @"
{
  "sourceService": "core-business",
  "alertType": "UNAUTHORIZED_ACCESS",
  "severity": "HIGH",
  "message": "Phat hien truy cap trai phep tai cong chinh",
  "relatedEventId": "0196fb3d-4ad7-7d1e-9f49-5d5148d2babc"
}
"@

curl.exe -i -X POST "$BaseUrl/notifications" `
  -H "$AuthHeader" `
  -H "Content-Type: application/json" `
  -d $payload

Write-Host "`n---"

Write-Host "[4/5] GET /notifications/recent without token"
curl.exe -i "$BaseUrl/notifications/recent"

Write-Host "`n---"

Write-Host "[5/5] POST invalid payload"

curl.exe -i -X POST "$BaseUrl/notifications" `
  -H "$AuthHeader" `
  -H "Content-Type: application/json" `
  -d "{ ""alertType"": 12345 }"