# SNS Service

### Send Message

#### Endpoint

`POST https://sns.octoblu.com/messages`

#### Headers

  - X-SNS-ARN
  - X-SNS-Device
  - X-SNS-Platform (Must be one of: IOS,ANDROID)

#### Body Params

  - devices
  - topic
  - payload

#### Example

```bash
curl -X POST https://sns.octoblu/messages \
  -H 'Content-Type: application/json' \
  -H 'X-SNS-ARN: arn:aws:sns:us-west-2:#####:app/APNS_SANDBOX/####' \
  -H 'X-SNS-Device: b73b036f-bfcf-4f2a-bad9-3157e6a6c124' \
  -H 'X-SNS-Platform: IOS' \
  -d '{"devices": "some-uuid", "topic": "push-ye", "payload": "Hello there friendly device"}'
```
