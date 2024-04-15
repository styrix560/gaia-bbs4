// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingsEventArgs {
  List<Booking> get newBookings => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Booking> newBookings) bookingsUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Booking> newBookings)? bookingsUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Booking> newBookings)? bookingsUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingsUpdated value) bookingsUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingsUpdated value)? bookingsUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingsUpdated value)? bookingsUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingsEventArgsCopyWith<BookingsEventArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsEventArgsCopyWith<$Res> {
  factory $BookingsEventArgsCopyWith(
          BookingsEventArgs value, $Res Function(BookingsEventArgs) then) =
      _$BookingsEventArgsCopyWithImpl<$Res, BookingsEventArgs>;
  @useResult
  $Res call({List<Booking> newBookings});
}

/// @nodoc
class _$BookingsEventArgsCopyWithImpl<$Res, $Val extends BookingsEventArgs>
    implements $BookingsEventArgsCopyWith<$Res> {
  _$BookingsEventArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newBookings = null,
  }) {
    return _then(_value.copyWith(
      newBookings: null == newBookings
          ? _value.newBookings
          : newBookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingsUpdatedImplCopyWith<$Res>
    implements $BookingsEventArgsCopyWith<$Res> {
  factory _$$BookingsUpdatedImplCopyWith(_$BookingsUpdatedImpl value,
          $Res Function(_$BookingsUpdatedImpl) then) =
      __$$BookingsUpdatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Booking> newBookings});
}

/// @nodoc
class __$$BookingsUpdatedImplCopyWithImpl<$Res>
    extends _$BookingsEventArgsCopyWithImpl<$Res, _$BookingsUpdatedImpl>
    implements _$$BookingsUpdatedImplCopyWith<$Res> {
  __$$BookingsUpdatedImplCopyWithImpl(
      _$BookingsUpdatedImpl _value, $Res Function(_$BookingsUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newBookings = null,
  }) {
    return _then(_$BookingsUpdatedImpl(
      null == newBookings
          ? _value._newBookings
          : newBookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>,
    ));
  }
}

/// @nodoc

class _$BookingsUpdatedImpl implements BookingsUpdated {
  const _$BookingsUpdatedImpl(final List<Booking> newBookings)
      : _newBookings = newBookings;

  final List<Booking> _newBookings;
  @override
  List<Booking> get newBookings {
    if (_newBookings is EqualUnmodifiableListView) return _newBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newBookings);
  }

  @override
  String toString() {
    return 'BookingsEventArgs.bookingsUpdated(newBookings: $newBookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingsUpdatedImpl &&
            const DeepCollectionEquality()
                .equals(other._newBookings, _newBookings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_newBookings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingsUpdatedImplCopyWith<_$BookingsUpdatedImpl> get copyWith =>
      __$$BookingsUpdatedImplCopyWithImpl<_$BookingsUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Booking> newBookings) bookingsUpdated,
  }) {
    return bookingsUpdated(newBookings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Booking> newBookings)? bookingsUpdated,
  }) {
    return bookingsUpdated?.call(newBookings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Booking> newBookings)? bookingsUpdated,
    required TResult orElse(),
  }) {
    if (bookingsUpdated != null) {
      return bookingsUpdated(newBookings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookingsUpdated value) bookingsUpdated,
  }) {
    return bookingsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookingsUpdated value)? bookingsUpdated,
  }) {
    return bookingsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookingsUpdated value)? bookingsUpdated,
    required TResult orElse(),
  }) {
    if (bookingsUpdated != null) {
      return bookingsUpdated(this);
    }
    return orElse();
  }
}

abstract class BookingsUpdated implements BookingsEventArgs {
  const factory BookingsUpdated(final List<Booking> newBookings) =
      _$BookingsUpdatedImpl;

  @override
  List<Booking> get newBookings;
  @override
  @JsonKey(ignore: true)
  _$$BookingsUpdatedImplCopyWith<_$BookingsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActiveBookingEventArgs {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveBookingEventArgsCopyWith<$Res> {
  factory $ActiveBookingEventArgsCopyWith(ActiveBookingEventArgs value,
          $Res Function(ActiveBookingEventArgs) then) =
      _$ActiveBookingEventArgsCopyWithImpl<$Res, ActiveBookingEventArgs>;
}

/// @nodoc
class _$ActiveBookingEventArgsCopyWithImpl<$Res,
        $Val extends ActiveBookingEventArgs>
    implements $ActiveBookingEventArgsCopyWith<$Res> {
  _$ActiveBookingEventArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActiveBookingActivatedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingActivatedEventArgsImplCopyWith(
          _$ActiveBookingActivatedEventArgsImpl value,
          $Res Function(_$ActiveBookingActivatedEventArgsImpl) then) =
      __$$ActiveBookingActivatedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Booking newBooking});
}

/// @nodoc
class __$$ActiveBookingActivatedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingActivatedEventArgsImpl>
    implements _$$ActiveBookingActivatedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingActivatedEventArgsImplCopyWithImpl(
      _$ActiveBookingActivatedEventArgsImpl _value,
      $Res Function(_$ActiveBookingActivatedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newBooking = null,
  }) {
    return _then(_$ActiveBookingActivatedEventArgsImpl(
      null == newBooking
          ? _value.newBooking
          : newBooking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class _$ActiveBookingActivatedEventArgsImpl
    implements ActiveBookingActivatedEventArgs {
  const _$ActiveBookingActivatedEventArgsImpl(this.newBooking);

  @override
  final Booking newBooking;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.activated(newBooking: $newBooking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingActivatedEventArgsImpl &&
            (identical(other.newBooking, newBooking) ||
                other.newBooking == newBooking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newBooking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingActivatedEventArgsImplCopyWith<
          _$ActiveBookingActivatedEventArgsImpl>
      get copyWith => __$$ActiveBookingActivatedEventArgsImplCopyWithImpl<
          _$ActiveBookingActivatedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return activated(newBooking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return activated?.call(newBooking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(newBooking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return activated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return activated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingActivatedEventArgs
    implements ActiveBookingEventArgs {
  const factory ActiveBookingActivatedEventArgs(final Booking newBooking) =
      _$ActiveBookingActivatedEventArgsImpl;

  Booking get newBooking;
  @JsonKey(ignore: true)
  _$$ActiveBookingActivatedEventArgsImplCopyWith<
          _$ActiveBookingActivatedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingDeactivatedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingDeactivatedEventArgsImplCopyWith(
          _$ActiveBookingDeactivatedEventArgsImpl value,
          $Res Function(_$ActiveBookingDeactivatedEventArgsImpl) then) =
      __$$ActiveBookingDeactivatedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Booking oldBooking});
}

/// @nodoc
class __$$ActiveBookingDeactivatedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingDeactivatedEventArgsImpl>
    implements _$$ActiveBookingDeactivatedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingDeactivatedEventArgsImplCopyWithImpl(
      _$ActiveBookingDeactivatedEventArgsImpl _value,
      $Res Function(_$ActiveBookingDeactivatedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldBooking = null,
  }) {
    return _then(_$ActiveBookingDeactivatedEventArgsImpl(
      null == oldBooking
          ? _value.oldBooking
          : oldBooking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class _$ActiveBookingDeactivatedEventArgsImpl
    implements ActiveBookingDeactivatedEventArgs {
  const _$ActiveBookingDeactivatedEventArgsImpl(this.oldBooking);

  @override
  final Booking oldBooking;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.deactivated(oldBooking: $oldBooking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingDeactivatedEventArgsImpl &&
            (identical(other.oldBooking, oldBooking) ||
                other.oldBooking == oldBooking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldBooking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingDeactivatedEventArgsImplCopyWith<
          _$ActiveBookingDeactivatedEventArgsImpl>
      get copyWith => __$$ActiveBookingDeactivatedEventArgsImplCopyWithImpl<
          _$ActiveBookingDeactivatedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return deactivated(oldBooking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return deactivated?.call(oldBooking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (deactivated != null) {
      return deactivated(oldBooking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return deactivated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return deactivated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (deactivated != null) {
      return deactivated(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingDeactivatedEventArgs
    implements ActiveBookingEventArgs {
  const factory ActiveBookingDeactivatedEventArgs(final Booking oldBooking) =
      _$ActiveBookingDeactivatedEventArgsImpl;

  Booking get oldBooking;
  @JsonKey(ignore: true)
  _$$ActiveBookingDeactivatedEventArgsImplCopyWith<
          _$ActiveBookingDeactivatedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingCreatedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingCreatedEventArgsImplCopyWith(
          _$ActiveBookingCreatedEventArgsImpl value,
          $Res Function(_$ActiveBookingCreatedEventArgsImpl) then) =
      __$$ActiveBookingCreatedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Booking activeBooking});
}

/// @nodoc
class __$$ActiveBookingCreatedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingCreatedEventArgsImpl>
    implements _$$ActiveBookingCreatedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingCreatedEventArgsImplCopyWithImpl(
      _$ActiveBookingCreatedEventArgsImpl _value,
      $Res Function(_$ActiveBookingCreatedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeBooking = null,
  }) {
    return _then(_$ActiveBookingCreatedEventArgsImpl(
      null == activeBooking
          ? _value.activeBooking
          : activeBooking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class _$ActiveBookingCreatedEventArgsImpl
    implements ActiveBookingCreatedEventArgs {
  const _$ActiveBookingCreatedEventArgsImpl(this.activeBooking);

  @override
  final Booking activeBooking;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.created(activeBooking: $activeBooking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingCreatedEventArgsImpl &&
            (identical(other.activeBooking, activeBooking) ||
                other.activeBooking == activeBooking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeBooking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingCreatedEventArgsImplCopyWith<
          _$ActiveBookingCreatedEventArgsImpl>
      get copyWith => __$$ActiveBookingCreatedEventArgsImplCopyWithImpl<
          _$ActiveBookingCreatedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return created(activeBooking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return created?.call(activeBooking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(activeBooking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingCreatedEventArgs implements ActiveBookingEventArgs {
  const factory ActiveBookingCreatedEventArgs(final Booking activeBooking) =
      _$ActiveBookingCreatedEventArgsImpl;

  Booking get activeBooking;
  @JsonKey(ignore: true)
  _$$ActiveBookingCreatedEventArgsImplCopyWith<
          _$ActiveBookingCreatedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingDeletedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingDeletedEventArgsImplCopyWith(
          _$ActiveBookingDeletedEventArgsImpl value,
          $Res Function(_$ActiveBookingDeletedEventArgsImpl) then) =
      __$$ActiveBookingDeletedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Booking oldBooking});
}

/// @nodoc
class __$$ActiveBookingDeletedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingDeletedEventArgsImpl>
    implements _$$ActiveBookingDeletedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingDeletedEventArgsImplCopyWithImpl(
      _$ActiveBookingDeletedEventArgsImpl _value,
      $Res Function(_$ActiveBookingDeletedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldBooking = null,
  }) {
    return _then(_$ActiveBookingDeletedEventArgsImpl(
      null == oldBooking
          ? _value.oldBooking
          : oldBooking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class _$ActiveBookingDeletedEventArgsImpl
    implements ActiveBookingDeletedEventArgs {
  const _$ActiveBookingDeletedEventArgsImpl(this.oldBooking);

  @override
  final Booking oldBooking;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.deleted(oldBooking: $oldBooking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingDeletedEventArgsImpl &&
            (identical(other.oldBooking, oldBooking) ||
                other.oldBooking == oldBooking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldBooking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingDeletedEventArgsImplCopyWith<
          _$ActiveBookingDeletedEventArgsImpl>
      get copyWith => __$$ActiveBookingDeletedEventArgsImplCopyWithImpl<
          _$ActiveBookingDeletedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return deleted(oldBooking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return deleted?.call(oldBooking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(oldBooking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingDeletedEventArgs implements ActiveBookingEventArgs {
  const factory ActiveBookingDeletedEventArgs(final Booking oldBooking) =
      _$ActiveBookingDeletedEventArgsImpl;

  Booking get oldBooking;
  @JsonKey(ignore: true)
  _$$ActiveBookingDeletedEventArgsImplCopyWith<
          _$ActiveBookingDeletedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingSeatAddedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingSeatAddedEventArgsImplCopyWith(
          _$ActiveBookingSeatAddedEventArgsImpl value,
          $Res Function(_$ActiveBookingSeatAddedEventArgsImpl) then) =
      __$$ActiveBookingSeatAddedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Seat newSeat});
}

/// @nodoc
class __$$ActiveBookingSeatAddedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingSeatAddedEventArgsImpl>
    implements _$$ActiveBookingSeatAddedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingSeatAddedEventArgsImplCopyWithImpl(
      _$ActiveBookingSeatAddedEventArgsImpl _value,
      $Res Function(_$ActiveBookingSeatAddedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newSeat = null,
  }) {
    return _then(_$ActiveBookingSeatAddedEventArgsImpl(
      null == newSeat
          ? _value.newSeat
          : newSeat // ignore: cast_nullable_to_non_nullable
              as Seat,
    ));
  }
}

/// @nodoc

class _$ActiveBookingSeatAddedEventArgsImpl
    implements ActiveBookingSeatAddedEventArgs {
  const _$ActiveBookingSeatAddedEventArgsImpl(this.newSeat);

  @override
  final Seat newSeat;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.seatAdded(newSeat: $newSeat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingSeatAddedEventArgsImpl &&
            (identical(other.newSeat, newSeat) || other.newSeat == newSeat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newSeat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingSeatAddedEventArgsImplCopyWith<
          _$ActiveBookingSeatAddedEventArgsImpl>
      get copyWith => __$$ActiveBookingSeatAddedEventArgsImplCopyWithImpl<
          _$ActiveBookingSeatAddedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return seatAdded(newSeat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return seatAdded?.call(newSeat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (seatAdded != null) {
      return seatAdded(newSeat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return seatAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return seatAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (seatAdded != null) {
      return seatAdded(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingSeatAddedEventArgs
    implements ActiveBookingEventArgs {
  const factory ActiveBookingSeatAddedEventArgs(final Seat newSeat) =
      _$ActiveBookingSeatAddedEventArgsImpl;

  Seat get newSeat;
  @JsonKey(ignore: true)
  _$$ActiveBookingSeatAddedEventArgsImplCopyWith<
          _$ActiveBookingSeatAddedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingSeatRemovedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingSeatRemovedEventArgsImplCopyWith(
          _$ActiveBookingSeatRemovedEventArgsImpl value,
          $Res Function(_$ActiveBookingSeatRemovedEventArgsImpl) then) =
      __$$ActiveBookingSeatRemovedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Seat oldSeat});
}

/// @nodoc
class __$$ActiveBookingSeatRemovedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingSeatRemovedEventArgsImpl>
    implements _$$ActiveBookingSeatRemovedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingSeatRemovedEventArgsImplCopyWithImpl(
      _$ActiveBookingSeatRemovedEventArgsImpl _value,
      $Res Function(_$ActiveBookingSeatRemovedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldSeat = null,
  }) {
    return _then(_$ActiveBookingSeatRemovedEventArgsImpl(
      null == oldSeat
          ? _value.oldSeat
          : oldSeat // ignore: cast_nullable_to_non_nullable
              as Seat,
    ));
  }
}

/// @nodoc

class _$ActiveBookingSeatRemovedEventArgsImpl
    implements ActiveBookingSeatRemovedEventArgs {
  const _$ActiveBookingSeatRemovedEventArgsImpl(this.oldSeat);

  @override
  final Seat oldSeat;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.seatRemoved(oldSeat: $oldSeat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingSeatRemovedEventArgsImpl &&
            (identical(other.oldSeat, oldSeat) || other.oldSeat == oldSeat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldSeat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingSeatRemovedEventArgsImplCopyWith<
          _$ActiveBookingSeatRemovedEventArgsImpl>
      get copyWith => __$$ActiveBookingSeatRemovedEventArgsImplCopyWithImpl<
          _$ActiveBookingSeatRemovedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return seatRemoved(oldSeat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return seatRemoved?.call(oldSeat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (seatRemoved != null) {
      return seatRemoved(oldSeat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return seatRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return seatRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (seatRemoved != null) {
      return seatRemoved(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingSeatRemovedEventArgs
    implements ActiveBookingEventArgs {
  const factory ActiveBookingSeatRemovedEventArgs(final Seat oldSeat) =
      _$ActiveBookingSeatRemovedEventArgsImpl;

  Seat get oldSeat;
  @JsonKey(ignore: true)
  _$$ActiveBookingSeatRemovedEventArgsImplCopyWith<
          _$ActiveBookingSeatRemovedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveBookingUpdatedEventArgsImplCopyWith<$Res> {
  factory _$$ActiveBookingUpdatedEventArgsImplCopyWith(
          _$ActiveBookingUpdatedEventArgsImpl value,
          $Res Function(_$ActiveBookingUpdatedEventArgsImpl) then) =
      __$$ActiveBookingUpdatedEventArgsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? firstName,
      String? lastName,
      String? className,
      int? paidAmount,
      PriceType? priceType});
}

/// @nodoc
class __$$ActiveBookingUpdatedEventArgsImplCopyWithImpl<$Res>
    extends _$ActiveBookingEventArgsCopyWithImpl<$Res,
        _$ActiveBookingUpdatedEventArgsImpl>
    implements _$$ActiveBookingUpdatedEventArgsImplCopyWith<$Res> {
  __$$ActiveBookingUpdatedEventArgsImplCopyWithImpl(
      _$ActiveBookingUpdatedEventArgsImpl _value,
      $Res Function(_$ActiveBookingUpdatedEventArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? className = freezed,
    Object? paidAmount = freezed,
    Object? priceType = freezed,
  }) {
    return _then(_$ActiveBookingUpdatedEventArgsImpl(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      priceType: freezed == priceType
          ? _value.priceType
          : priceType // ignore: cast_nullable_to_non_nullable
              as PriceType?,
    ));
  }
}

/// @nodoc

class _$ActiveBookingUpdatedEventArgsImpl
    implements ActiveBookingUpdatedEventArgs {
  const _$ActiveBookingUpdatedEventArgsImpl(
      {this.firstName,
      this.lastName,
      this.className,
      this.paidAmount,
      this.priceType});

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? className;
  @override
  final int? paidAmount;
  @override
  final PriceType? priceType;

  @override
  String toString() {
    return 'ActiveBookingEventArgs.updated(firstName: $firstName, lastName: $lastName, className: $className, paidAmount: $paidAmount, priceType: $priceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveBookingUpdatedEventArgsImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.priceType, priceType) ||
                other.priceType == priceType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, firstName, lastName, className, paidAmount, priceType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveBookingUpdatedEventArgsImplCopyWith<
          _$ActiveBookingUpdatedEventArgsImpl>
      get copyWith => __$$ActiveBookingUpdatedEventArgsImplCopyWithImpl<
          _$ActiveBookingUpdatedEventArgsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Booking newBooking) activated,
    required TResult Function(Booking oldBooking) deactivated,
    required TResult Function(Booking activeBooking) created,
    required TResult Function(Booking oldBooking) deleted,
    required TResult Function(Seat newSeat) seatAdded,
    required TResult Function(Seat oldSeat) seatRemoved,
    required TResult Function(String? firstName, String? lastName,
            String? className, int? paidAmount, PriceType? priceType)
        updated,
  }) {
    return updated(firstName, lastName, className, paidAmount, priceType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Booking newBooking)? activated,
    TResult? Function(Booking oldBooking)? deactivated,
    TResult? Function(Booking activeBooking)? created,
    TResult? Function(Booking oldBooking)? deleted,
    TResult? Function(Seat newSeat)? seatAdded,
    TResult? Function(Seat oldSeat)? seatRemoved,
    TResult? Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
  }) {
    return updated?.call(firstName, lastName, className, paidAmount, priceType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Booking newBooking)? activated,
    TResult Function(Booking oldBooking)? deactivated,
    TResult Function(Booking activeBooking)? created,
    TResult Function(Booking oldBooking)? deleted,
    TResult Function(Seat newSeat)? seatAdded,
    TResult Function(Seat oldSeat)? seatRemoved,
    TResult Function(String? firstName, String? lastName, String? className,
            int? paidAmount, PriceType? priceType)?
        updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(firstName, lastName, className, paidAmount, priceType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveBookingActivatedEventArgs value) activated,
    required TResult Function(ActiveBookingDeactivatedEventArgs value)
        deactivated,
    required TResult Function(ActiveBookingCreatedEventArgs value) created,
    required TResult Function(ActiveBookingDeletedEventArgs value) deleted,
    required TResult Function(ActiveBookingSeatAddedEventArgs value) seatAdded,
    required TResult Function(ActiveBookingSeatRemovedEventArgs value)
        seatRemoved,
    required TResult Function(ActiveBookingUpdatedEventArgs value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult? Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult? Function(ActiveBookingCreatedEventArgs value)? created,
    TResult? Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult? Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult? Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult? Function(ActiveBookingUpdatedEventArgs value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveBookingActivatedEventArgs value)? activated,
    TResult Function(ActiveBookingDeactivatedEventArgs value)? deactivated,
    TResult Function(ActiveBookingCreatedEventArgs value)? created,
    TResult Function(ActiveBookingDeletedEventArgs value)? deleted,
    TResult Function(ActiveBookingSeatAddedEventArgs value)? seatAdded,
    TResult Function(ActiveBookingSeatRemovedEventArgs value)? seatRemoved,
    TResult Function(ActiveBookingUpdatedEventArgs value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class ActiveBookingUpdatedEventArgs implements ActiveBookingEventArgs {
  const factory ActiveBookingUpdatedEventArgs(
      {final String? firstName,
      final String? lastName,
      final String? className,
      final int? paidAmount,
      final PriceType? priceType}) = _$ActiveBookingUpdatedEventArgsImpl;

  String? get firstName;
  String? get lastName;
  String? get className;
  int? get paidAmount;
  PriceType? get priceType;
  @JsonKey(ignore: true)
  _$$ActiveBookingUpdatedEventArgsImplCopyWith<
          _$ActiveBookingUpdatedEventArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
