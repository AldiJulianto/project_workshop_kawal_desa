import 'package:dart_amqp/dart_amqp.dart';
import 'package:project_workshop_kawal_desa/constants/const.dart';
class RmqService {
  final String queues ="";
  Client connect(){
    ConnectionSettings settings = new ConnectionSettings (
      host: RMQ_HOST,
      authProvider: new PlainAuthenticator(RMQ_USER, RMQ_PASS),
      virtualHost: RMQ_VHOST
    );
    Client client = new Client(settings: settings);
    return client;
  }

  void publish(String message) {
    ConnectionSettings settings = new ConnectionSettings (
      host: RMQ_HOST,
      authProvider: new PlainAuthenticator (RMQ_USER, RMQ_PASS),
      virtualHost: RMQ_VHOST
    );
    Client client = new Client(settings: settings);
    client.channel().then((Channel channel) {
      return channel.queue(queues, durable: true);
    }).then((Queue queue) {
      queue.publish(message);
      client.close();
    }) ;
  }
}