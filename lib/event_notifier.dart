import "package:bbs4/types.dart";
import "package:supernova/supernova.dart";

part "event_notifier.freezed.dart";

@freezed
sealed class BookingsEventArgs with _$BookingsEventArgs {
  // bookings-events
  const factory BookingsEventArgs.bookingsUpdated(List<Booking> newBookings) =
      BookingsUpdated;
}

@freezed
sealed class ActiveBookingEventArgs with _$ActiveBookingEventArgs {
  // activeBooking-events
  const factory ActiveBookingEventArgs.activated(Booking newBooking) =
      ActiveBookingActivatedEventArgs;

  const factory ActiveBookingEventArgs.deactivated(Booking oldBooking) =
      ActiveBookingDeactivatedEventArgs;

  const factory ActiveBookingEventArgs.created(Booking activeBooking) =
      ActiveBookingCreatedEventArgs;

  const factory ActiveBookingEventArgs.deleted(Booking oldBooking) =
      ActiveBookingDeletedEventArgs;

  const factory ActiveBookingEventArgs.seatAdded(
    Seat newSeat,
  ) = ActiveBookingSeatAddedEventArgs;

  const factory ActiveBookingEventArgs.seatRemoved(
    Seat oldSeat,
  ) = ActiveBookingSeatRemovedEventArgs;

  // this event is only for updates that do not concern seats - there are
  // separate events for that
  const factory ActiveBookingEventArgs.updated({
    String? firstName,
    String? lastName,
    String? className,
    int? pricePaid,
    PriceType? priceType,
  }) = ActiveBookingUpdatedEventArgs;
}

// the type 'A' describes the EventArgs for the event-notifier
class EventNotifier<A> {
  final List<ValueChanged<A>> _listeners = [];

  VoidCallback addListener<E extends A>(ValueChanged<E> listener) {
    void wrapper(A eventArgsType) {
      if (eventArgsType is E) {
        logger.debug("event callback called", E);
        listener(eventArgsType);
      }
    }

    _listeners.add(wrapper);
    return () => _listeners.remove(wrapper);
  }

  void notifyListeners(A event) {
    for (final listener in _listeners) {
      try {
        listener.call(event);
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        logger.error("Error calling callback", e);
      }
    }
  }
}
