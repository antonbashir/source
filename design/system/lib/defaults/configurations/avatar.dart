part of '../defaults.dart';

final _avatarConfiguration = Breakpoints(
    AvatarConfiguration(
      borderRadius: _borders.small,
      avatarSizeValue: 32,
      badgeMarginValue: 32 * 4 / 64,
      badgeSizeValue: 32 * 12 / 64,
      textStyle: _typography.base.titleMedium,
    ),
    {
      BreakpointSize.tiny: AvatarConfiguration(
        borderRadius: _borders.tiny,
        avatarSizeValue: 24,
        badgeMarginValue: 24 * 4 / 64,
        badgeSizeValue: 24 * 12 / 64,
        textStyle: _typography.base.titleSmall,
      ),
      BreakpointSize.small: AvatarConfiguration(
        borderRadius: _borders.small,
        avatarSizeValue: 32,
        badgeMarginValue: 32 * 4 / 64,
        badgeSizeValue: 32 * 12 / 64,
        textStyle: _typography.base.titleMedium,
      ),
      BreakpointSize.medium: AvatarConfiguration(
        borderRadius: _borders.small,
        avatarSizeValue: 40,
        badgeMarginValue: 40 * 4 / 64,
        badgeSizeValue: 40 * 12 / 64,
        textStyle: _typography.base.titleMedium,
      ),
      BreakpointSize.large: AvatarConfiguration(
        borderRadius: _borders.small,
        avatarSizeValue: 48,
        badgeMarginValue: 48 * 4 / 64,
        badgeSizeValue: 48 * 12 / 64,
        textStyle: _typography.base.titleLarge,
      ),
      BreakpointSize.gigantic: AvatarConfiguration(
        borderRadius: _borders.medium,
        avatarSizeValue: 56,
        badgeMarginValue: 56 * 4 / 64,
        badgeSizeValue: 56 * 12 / 64,
        textStyle: _typography.base.titleLarge,
      ),
      BreakpointSize.colossal: AvatarConfiguration(
        borderRadius: _borders.medium,
        avatarSizeValue: 64,
        badgeMarginValue: 64 * 4 / 64,
        badgeSizeValue: 64 * 12 / 64,
        textStyle: _typography.base.displaySmall,
      ),
    });
