part of '../composites.dart';

class _AuthenticationCode extends StatefulWidget {
  const _AuthenticationCode();

  @override
  State<_AuthenticationCode> createState() => _AuthenticationCodeState();
}

class _AuthenticationCodeState extends State<_AuthenticationCode> {
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(shape: SquircleBorder(borderRadius: context.borders.medium.squircle(context), side: BorderSide(color: context.colors.border))),
        child: Padding(
          padding: EdgeInsets.all(context.spacings.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(context.spacings.small),
                child: Text("Authentication Code", style: context.typography.base.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacings.medium),
                child: Row(
                  children: [
                    AuthenticationCode(
                      width: 500,
                      validator: (String? value) => null,
                      errorBuilder: (BuildContext context, String? errorText) => Container(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
