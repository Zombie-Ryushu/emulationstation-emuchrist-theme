#!/bin/bash
echo "Fixing carousel properties..."

# Replace logoSize with itemSize
find . -name "*.xml" -type f -exec sed -i 's/<logoSize>/<itemSize>/g; s/<\/logoSize>/<\/itemSize>/g' {} \;

# Replace logoScale with itemScale
find . -name "*.xml" -type f -exec sed -i 's/<logoScale>/<itemScale>/g; s/<\/logoScale>/<\/itemScale>/g' {} \;

# Replace logoRotation with itemRotation
find . -name "*.xml" -type f -exec sed -i 's/<logoRotation>/<itemRotation>/g; s/<\/logoRotation>/<\/itemRotation>/g' {} \;

# Replace logoRotationOrigin with itemRotationOrigin
find . -name "*.xml" -type f -exec sed -i 's/<logoRotationOrigin>/<itemRotationOrigin>/g; s/<\/logoRotationOrigin>/<\/itemRotationOrigin>/g' {} \;

# Replace logoAlignment with itemHorizontalAlignment
find . -name "*.xml" -type f -exec sed -i 's/<logoAlignment>/<itemHorizontalAlignment>/g; s/<\/logoAlignment>/<\/itemHorizontalAlignment>/g' {} \;

echo "Carousel property fixes complete!"
