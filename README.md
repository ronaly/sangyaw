# sangyaw
how to build a release

1) change version in pubspec.yaml
see: https://pub.dev/packages/pubspec_version
to install version tool:

pub global activate pubspec_version
add ~/.pub-cache/bin to path

to change build version 

# build
# from  1.0.0+42 to 1.0.0+43
pubver bump build

# patch
# from 1.0.0 to 1.0.1
pubver bump patch

# minor
# from 1.0.0 to 1.1.0
pubver bump minor

# major
# from 1.0.0 to 2.0.0
pubver bump major

## the usual use
pubver bump patch



2) run command in sangyaw app base directory
flutter build apk --split-per-abi


3) upload to google drive, releases


- Summary of deployment commands

pubver bump patch
flutter build apk --split-per-abi

