import 'package:design/model/theme.dart';
import 'package:design/theme/composites/accordion/theme.dart';
import 'package:design/theme/composites/alert/theme.dart';
import 'package:design/theme/composites/authentication/theme.dart';
import 'package:design/theme/composites/breadcrumb/theme.dart';
import 'package:design/theme/composites/code/theme.dart';
import 'package:design/theme/composites/toast/theme.dart';
import 'package:design/theme/effects/effects.dart';
import 'package:design/theme/layouts/scrollbar/theme.dart';
import 'package:design/theme/layouts/sidebar/drawer/theme.dart';
import 'package:design/theme/layouts/sidebar/sidebar/theme.dart';
import 'package:design/theme/layouts/tab/theme.dart';
import 'package:design/theme/primitives/avatar/theme.dart';
import 'package:design/theme/primitives/button/theme.dart';
import 'package:design/theme/primitives/checkbox/theme.dart';
import 'package:design/theme/primitives/chip/theme.dart';
import 'package:design/theme/primitives/divider/theme.dart';
import 'package:design/theme/primitives/dots/theme.dart';
import 'package:design/theme/primitives/item/theme.dart';
import 'package:design/theme/primitives/label/theme.dart';
import 'package:design/theme/primitives/loaders/circular/theme.dart';
import 'package:design/theme/primitives/loaders/linear/theme.dart';
import 'package:design/theme/primitives/pins/theme.dart';
import 'package:design/theme/primitives/progress/circular/theme.dart';
import 'package:design/theme/primitives/progress/linear/theme.dart';
import 'package:design/theme/primitives/radio/theme.dart';
import 'package:design/theme/primitives/segments/theme.dart';
import 'package:design/theme/primitives/switch/theme.dart';
import 'package:design/theme/primitives/tag/theme.dart';
import 'package:design/theme/primitives/text/area/theme.dart';
import 'package:design/theme/primitives/text/input/theme.dart';
import 'package:design/theme/primitives/text/selection/theme.dart';
import 'package:design/theme/tokens/tokens.dart';
import 'package:design/theme/views/carousel/theme.dart';
import 'package:design/theme/views/dropdown/theme.dart';
import 'package:design/theme/views/modal/theme.dart';
import 'package:design/theme/views/popover/theme.dart';
import 'package:flutter/foundation.dart';

class ThemeConfiguration {
  Tokens _tokens;
  final Brightness brightness;
  final ThemeMutable<AccordionTheme, Tokens> accordionTheme;
  final ThemeMutable<AlertTheme, Tokens> alertTheme;
  final ThemeMutable<AuthenticationCodeTheme, Tokens> authenticationCodeTheme;
  final ThemeMutable<AvatarTheme, Tokens> avatarTheme;
  final ThemeMutable<BreadcrumbsTheme, Tokens> breadcrumbsTheme;
  final ThemeMutable<ButtonTheme, Tokens> buttonTheme;
  final ThemeMutable<CarouselTheme, Tokens> carouselTheme;
  final ThemeMutable<CheckboxTheme, Tokens> checkboxTheme;
  final ThemeMutable<ChipTheme, Tokens> chipTheme;
  final ThemeMutable<CircularLoaderTheme, Tokens> circularLoaderTheme;
  final ThemeMutable<CircularProgressTheme, Tokens> circularProgressTheme;
  final ThemeMutable<DotsIndicatorTheme, Tokens> dotsIndicatorTheme;
  final ThemeMutable<DrawerTheme, Tokens> drawerTheme;
  final ThemeMutable<DropdownTheme, Tokens> dropdownTheme;
  final ThemeMutable<EffectsTheme, Tokens> effectsTheme;
  final ThemeMutable<LinearLoaderTheme, Tokens> linearLoaderTheme;
  final ThemeMutable<LinearProgressTheme, Tokens> linearProgressTheme;
  final ThemeMutable<ListItemTheme, Tokens> listItemTheme;
  final ThemeMutable<LabelTheme, Tokens> labelTheme;
  final ThemeMutable<ModalTheme, Tokens> modalTheme;
  final ThemeMutable<PopoverTheme, Tokens> popoverTheme;
  final ThemeMutable<ProgressPinTheme, Tokens> progressPinTheme;
  final ThemeMutable<RadioTheme, Tokens> radioTheme;
  final ThemeMutable<SegmentedControlTheme, Tokens> segmentedControlTheme;
  final ThemeMutable<SwitchTheme, Tokens> switchTheme;
  final ThemeMutable<TabBarTheme, Tokens> tabBarTheme;
  final ThemeMutable<TagTheme, Tokens> tagTheme;
  final ThemeMutable<TextAreaTheme, Tokens> textAreaTheme;
  final ThemeMutable<TextInputTheme, Tokens> textInputTheme;
  final ThemeMutable<ToastTheme, Tokens> toastTheme;
  final ThemeMutable<CodeTheme, Tokens> codeTheme;
  final ThemeMutable<DividerTheme, Tokens> dividerTheme;
  final ThemeMutable<ScrollbarTheme, Tokens> scrollbarTheme;
  final ThemeMutable<TextSelectionTheme, Tokens> textSelectionTheme;
  final ThemeMutable<SidebarTheme, Tokens> sidebarTheme;

  Tokens get tokens => _tokens;

  ThemeConfiguration(
    this._tokens, {
    required this.brightness,
    required this.accordionTheme,
    required this.alertTheme,
    required this.authenticationCodeTheme,
    required this.avatarTheme,
    required this.breadcrumbsTheme,
    required this.buttonTheme,
    required this.carouselTheme,
    required this.checkboxTheme,
    required this.chipTheme,
    required this.circularLoaderTheme,
    required this.circularProgressTheme,
    required this.dotsIndicatorTheme,
    required this.drawerTheme,
    required this.dropdownTheme,
    required this.effectsTheme,
    required this.linearLoaderTheme,
    required this.linearProgressTheme,
    required this.listItemTheme,
    required this.labelTheme,
    required this.modalTheme,
    required this.popoverTheme,
    required this.progressPinTheme,
    required this.radioTheme,
    required this.segmentedControlTheme,
    required this.switchTheme,
    required this.tabBarTheme,
    required this.tagTheme,
    required this.textAreaTheme,
    required this.textInputTheme,
    required this.toastTheme,
    required this.codeTheme,
    required this.dividerTheme,
    required this.scrollbarTheme,
    required this.textSelectionTheme,
    required this.sidebarTheme,
  });

  ThemeConfiguration copyWith({
    Brightness? brightness,
    Tokens? tokens,
    ThemeMutable<AccordionTheme, Tokens>? accordionTheme,
    ThemeMutable<AlertTheme, Tokens>? alertTheme,
    ThemeMutable<AuthenticationCodeTheme, Tokens>? authenticationCodeTheme,
    ThemeMutable<AvatarTheme, Tokens>? avatarTheme,
    ThemeMutable<BreadcrumbsTheme, Tokens>? breadcrumbsTheme,
    ThemeMutable<ButtonTheme, Tokens>? buttonTheme,
    ThemeMutable<CarouselTheme, Tokens>? carouselTheme,
    ThemeMutable<CheckboxTheme, Tokens>? checkboxTheme,
    ThemeMutable<ChipTheme, Tokens>? chipTheme,
    ThemeMutable<CircularLoaderTheme, Tokens>? circularLoaderTheme,
    ThemeMutable<CircularProgressTheme, Tokens>? circularProgressTheme,
    ThemeMutable<DotsIndicatorTheme, Tokens>? dotsIndicatorTheme,
    ThemeMutable<DrawerTheme, Tokens>? drawerTheme,
    ThemeMutable<DropdownTheme, Tokens>? dropdownTheme,
    ThemeMutable<LinearLoaderTheme, Tokens>? linearLoaderTheme,
    ThemeMutable<LinearProgressTheme, Tokens>? linearProgressTheme,
    ThemeMutable<ListItemTheme, Tokens>? listItemTheme,
    ThemeMutable<LabelTheme, Tokens>? labelTheme,
    ThemeMutable<ModalTheme, Tokens>? modalTheme,
    ThemeMutable<PopoverTheme, Tokens>? popoverTheme,
    ThemeMutable<ProgressPinTheme, Tokens>? progressPinTheme,
    ThemeMutable<RadioTheme, Tokens>? radioTheme,
    ThemeMutable<SegmentedControlTheme, Tokens>? segmentedControlTheme,
    ThemeMutable<SwitchTheme, Tokens>? switchTheme,
    ThemeMutable<TabBarTheme, Tokens>? tabBarTheme,
    ThemeMutable<TagTheme, Tokens>? tagTheme,
    ThemeMutable<TextAreaTheme, Tokens>? textAreaTheme,
    ThemeMutable<TextInputTheme, Tokens>? textInputTheme,
    ThemeMutable<ToastTheme, Tokens>? toastTheme,
    ThemeMutable<CodeTheme, Tokens>? codeTheme,
    ThemeMutable<DividerTheme, Tokens>? dividerTheme,
    ThemeMutable<ScrollbarTheme, Tokens>? scrollbarTheme,
    ThemeMutable<TextSelectionTheme, Tokens>? textSelectionTheme,
    ThemeMutable<SidebarTheme, Tokens>? sidebarTheme,
    ThemeMutable<EffectsTheme, Tokens>? effectsTheme,
  }) =>
      ThemeConfiguration(
        tokens ?? _tokens,
        brightness: brightness ?? this.brightness,
        accordionTheme: accordionTheme ?? this.accordionTheme,
        alertTheme: alertTheme ?? this.alertTheme,
        authenticationCodeTheme: authenticationCodeTheme ?? this.authenticationCodeTheme,
        avatarTheme: avatarTheme ?? this.avatarTheme,
        breadcrumbsTheme: breadcrumbsTheme ?? this.breadcrumbsTheme,
        buttonTheme: buttonTheme ?? this.buttonTheme,
        carouselTheme: carouselTheme ?? this.carouselTheme,
        checkboxTheme: checkboxTheme ?? this.checkboxTheme,
        chipTheme: chipTheme ?? this.chipTheme,
        circularLoaderTheme: circularLoaderTheme ?? this.circularLoaderTheme,
        circularProgressTheme: circularProgressTheme ?? this.circularProgressTheme,
        dotsIndicatorTheme: dotsIndicatorTheme ?? this.dotsIndicatorTheme,
        drawerTheme: drawerTheme ?? this.drawerTheme,
        dropdownTheme: dropdownTheme ?? this.dropdownTheme,
        effectsTheme: effectsTheme ?? this.effectsTheme,
        linearLoaderTheme: linearLoaderTheme ?? this.linearLoaderTheme,
        linearProgressTheme: linearProgressTheme ?? this.linearProgressTheme,
        listItemTheme: listItemTheme ?? this.listItemTheme,
        labelTheme: labelTheme ?? this.labelTheme,
        modalTheme: modalTheme ?? this.modalTheme,
        popoverTheme: popoverTheme ?? this.popoverTheme,
        progressPinTheme: progressPinTheme ?? this.progressPinTheme,
        radioTheme: radioTheme ?? this.radioTheme,
        segmentedControlTheme: segmentedControlTheme ?? this.segmentedControlTheme,
        switchTheme: switchTheme ?? this.switchTheme,
        tabBarTheme: tabBarTheme ?? this.tabBarTheme,
        tagTheme: tagTheme ?? this.tagTheme,
        textAreaTheme: textAreaTheme ?? this.textAreaTheme,
        textInputTheme: textInputTheme ?? this.textInputTheme,
        toastTheme: toastTheme ?? this.toastTheme,
        codeTheme: codeTheme ?? this.codeTheme,
        dividerTheme: dividerTheme ?? this.dividerTheme,
        scrollbarTheme: scrollbarTheme ?? this.scrollbarTheme,
        textSelectionTheme: textSelectionTheme ?? this.textSelectionTheme,
        sidebarTheme: sidebarTheme ?? this.sidebarTheme,
      ).mutate(tokens ?? _tokens);

  ThemeConfiguration lerp(ThemeConfiguration? other, double t) {
    if (other is! ThemeConfiguration) return this;
    return ThemeConfiguration(
      _tokens.lerp(other._tokens, t),
      brightness: other.brightness,
      accordionTheme: accordionTheme.lerp(other.accordionTheme, t),
      alertTheme: alertTheme.lerp(other.alertTheme, t),
      authenticationCodeTheme: authenticationCodeTheme.lerp(other.authenticationCodeTheme, t),
      avatarTheme: avatarTheme.lerp(other.avatarTheme, t),
      breadcrumbsTheme: breadcrumbsTheme.lerp(other.breadcrumbsTheme, t),
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      carouselTheme: carouselTheme.lerp(other.carouselTheme, t),
      checkboxTheme: checkboxTheme.lerp(other.checkboxTheme, t),
      chipTheme: chipTheme.lerp(other.chipTheme, t),
      circularLoaderTheme: circularLoaderTheme.lerp(other.circularLoaderTheme, t),
      circularProgressTheme: circularProgressTheme.lerp(other.circularProgressTheme, t),
      dotsIndicatorTheme: dotsIndicatorTheme.lerp(other.dotsIndicatorTheme, t),
      drawerTheme: drawerTheme.lerp(other.drawerTheme, t),
      dropdownTheme: dropdownTheme.lerp(other.dropdownTheme, t),
      effectsTheme: effectsTheme.lerp(other.effectsTheme, t),
      linearLoaderTheme: linearLoaderTheme.lerp(other.linearLoaderTheme, t),
      linearProgressTheme: linearProgressTheme.lerp(other.linearProgressTheme, t),
      listItemTheme: listItemTheme.lerp(other.listItemTheme, t),
      labelTheme: labelTheme.lerp(other.labelTheme, t),
      modalTheme: modalTheme.lerp(other.modalTheme, t),
      popoverTheme: popoverTheme.lerp(other.popoverTheme, t),
      progressPinTheme: progressPinTheme.lerp(other.progressPinTheme, t),
      radioTheme: radioTheme.lerp(other.radioTheme, t),
      segmentedControlTheme: segmentedControlTheme.lerp(other.segmentedControlTheme, t),
      switchTheme: switchTheme.lerp(other.switchTheme, t),
      tabBarTheme: tabBarTheme.lerp(other.tabBarTheme, t),
      tagTheme: tagTheme.lerp(other.tagTheme, t),
      textAreaTheme: textAreaTheme.lerp(other.textAreaTheme, t),
      textInputTheme: textInputTheme.lerp(other.textInputTheme, t),
      toastTheme: toastTheme.lerp(other.toastTheme, t),
      codeTheme: codeTheme.lerp(other.codeTheme, t),
      dividerTheme: dividerTheme.lerp(other.dividerTheme, t),
      scrollbarTheme: scrollbarTheme.lerp(other.scrollbarTheme, t),
      textSelectionTheme: textSelectionTheme.lerp(other.textSelectionTheme, t),
      sidebarTheme: sidebarTheme.lerp(other.sidebarTheme, t),
    ).mutate(_tokens.lerp(other._tokens, t));
  }

  ThemeConfiguration mutate(Tokens tokens) {
    _tokens = tokens;
    accordionTheme.mutate(tokens);
    alertTheme.mutate(tokens);
    authenticationCodeTheme.mutate(tokens);
    avatarTheme.mutate(tokens);
    breadcrumbsTheme.mutate(tokens);
    buttonTheme.mutate(tokens);
    carouselTheme.mutate(tokens);
    checkboxTheme.mutate(tokens);
    chipTheme.mutate(tokens);
    circularLoaderTheme.mutate(tokens);
    circularProgressTheme.mutate(tokens);
    dotsIndicatorTheme.mutate(tokens);
    drawerTheme.mutate(tokens);
    dropdownTheme.mutate(tokens);
    effectsTheme.mutate(tokens);
    linearLoaderTheme.mutate(tokens);
    linearProgressTheme.mutate(tokens);
    listItemTheme.mutate(tokens);
    labelTheme.mutate(tokens);
    modalTheme.mutate(tokens);
    popoverTheme.mutate(tokens);
    progressPinTheme.mutate(tokens);
    radioTheme.mutate(tokens);
    segmentedControlTheme.mutate(tokens);
    switchTheme.mutate(tokens);
    tabBarTheme.mutate(tokens);
    tagTheme.mutate(tokens);
    textAreaTheme.mutate(tokens);
    textInputTheme.mutate(tokens);
    toastTheme.mutate(tokens);
    codeTheme.mutate(tokens);
    dividerTheme.mutate(tokens);
    scrollbarTheme.mutate(tokens);
    textSelectionTheme.mutate(tokens);
    sidebarTheme.mutate(tokens);
    return this;
  }
}
