# SNS Service

### Register Device

#### Endpoint

`POST https://sns.octoblu.com/devices`

#### Headers

  - X-SNS-ARN
  - X-SNS-Device
  - X-SNS-Platform (Must be one of: "IOS","ANDROID")
  - X-SNS-Sandbox (optional. Must be one of "true"/"false")

#### Example

```bash
curl -X POST https://sns.octoblu/devices \
  -H 'X-SNS-ARN: arn:aws:sns:us-west-2:#####:app/APNS_SANDBOX/####' \
  -H 'X-SNS-Device: b73b036f-bfcf-4f2a-bad9-3157e6a6c124' \
  -H 'X-SNS-Platform: IOS' \
  -H 'X-SNS-Sandbox: true'
```

### Send Message

#### Endpoint

`POST https://sns.octoblu.com/messages`

#### Headers

  - X-SNS-ARN
  - X-SNS-Endpoint
  - X-SNS-Platform (Must be one of: IOS,ANDROID)
  - X-SNS-Sandbox (optional. Must be one of "true"/"false")

#### Body Params

  - devices
  - topic
  - payload

#### Example

```bash
curl -X POST https://sns.octoblu/messages \
  -H 'Content-Type: application/json' \
  -H 'X-SNS-ARN: arn:aws:sns:us-west-2:#####:app/APNS_SANDBOX/####' \
  -H 'X-SNS-Endpoint: arn:aws:sns:us-west-2:#####:endpoint/APNS_SANDBOX/####/9a313a1c-525c-3147-9eca-593d484170f6' \
  -H 'X-SNS-Platform: IOS' \
  -H 'X-SNS-Sandbox: true' \
  -d '{"devices": "some-uuid", "topic": "push-ye", "payload": "Hello there friendly device"}'
```
