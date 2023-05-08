import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_tickets_event.dart';
part 'my_tickets_state.dart';

class MyTicketsBloc extends Bloc<MyTicketsEvent, MyTicketsState> {
  MyTicketsBloc() : super(MyTicketsInitial()) {
    on<MyTicketsEvent>((event, emit) {});
  }
}
