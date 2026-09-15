#!/usr/bin/env bash
echo "Running predeploy script..."

aws s3 sync build/web s3://dev.lbg.apt.alphaport.at --delete

# echo "Running postdeploy script..."
export DISTRIBUTION_ID=E3UAUXK3FJNKDO
INVALIDATION_ID=$(aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths "/*" --query 'Invalidation.Id' --output text)
echo "Invalidating $DISTRIBUTION_ID with $INVALIDATION_ID"
aws cloudfront wait invalidation-completed --distribution-id ${DISTRIBUTION_ID} --id ${INVALIDATION_ID}
echo "Success"