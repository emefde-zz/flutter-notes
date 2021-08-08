#!/bin/bash -e
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/post_integration_test.dart \
  -d DA6845B6-C2A6-4329-A47D-CA3CD2C9559C