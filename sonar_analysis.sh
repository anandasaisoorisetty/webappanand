#!/bin/bash

# Perform SonarQube analysis
sonarScanner="node_modules/sonar-scanner/bin/sonar-scanner"
npmRunSonar="npm run sonar"

sonar_output=$($sonarScanner | tee /dev/tty)

# Execute npm run sonar
$npmRunSonar

# If SonarQube doesn't output severity information directly, adjust the grep patterns accordingly
critical_issues=$(echo "$sonar_output" | grep -i "CRITICAL" | wc -l)
high_issues=$(echo "$sonar_output" | grep -i "HIGH" | wc -l)

echo "High issues: $high_issues"
echo "Critical issues: $critical_issues"

# Check if there are critical issues in the analysis results
if [[ $high_issues -gt 0 || $critical_issues -gt 0 ]]; then
    echo "Your code has high-severity or critical issues"
    # AWS SNS notification
    aws sns publish --topic-arn $arn --message "Code issues: High or critical issues detected" --subject "Code Issue Alert"
    currentBuild.result = 'FAILURE'  # Mark the build as failed
else
    echo "Your code has no or low-severity issues"
fi
