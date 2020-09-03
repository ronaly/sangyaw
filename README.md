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
flutter pubver bump build

# patch
# from 1.0.0 to 1.0.1
flutter pubver bump patch

# minor
# from 1.0.0 to 1.1.0
flutter pubver bump minor

# major
# from 1.0.0 to 2.0.0
flutter pubver bump major

## the usual use
flutter pubver bump minor



2) run command in sangyaw app base directory
flutter build apk --split-per-abi

