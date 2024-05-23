import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_listin/listins/models/listin.dart";
import "package:flutter_listin/listins/services/listin_service.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "listin_service_test.mocks.dart";

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<QueryDocumentSnapshot>(),
])
void main() {
  group("getListins:", () {
    late String uid;
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference<Map<String, dynamic>> mockCollection;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();

      mockCollection = MockCollectionReference();

      MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot =
          MockQuerySnapshot();

      MockQueryDocumentSnapshot<Map<String, dynamic>> mockDoc001 =
          MockQueryDocumentSnapshot();

      MockQueryDocumentSnapshot<Map<String, dynamic>> mockDoc002 =
          MockQueryDocumentSnapshot();

      uid = "MEU_UID";

      Listin listin001 = Listin(
        id: "ID001",
        name: "Feira de Maio",
        obs: "",
        dateCreate: DateTime.now().subtract(
          const Duration(days: 32),
        ),
        dateUpdate: DateTime.now().subtract(
          const Duration(days: 32),
        ),
      );

      Listin listin002 = Listin(
        id: "ID001",
        name: "Feira de Junho",
        obs: "",
        dateCreate: DateTime.now(),
        dateUpdate: DateTime.now(),
      );

      when(mockDoc001.data()).thenReturn(listin001.toMap());
      when(mockDoc002.data()).thenReturn(listin002.toMap());

      when(mockQuerySnapshot.docs).thenReturn([mockDoc001, mockDoc002]);

      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

      when(mockFirestore.collection(uid)).thenReturn(mockCollection);
    });

    test("O método deve retornar uma lista de Listins", () async {
      ListinService listinService = ListinService(
        uid: uid,
        firestore: mockFirestore,
      );

      List<Listin> result = await listinService.getListins();
      expect(result.length, 2);
    });

    test("O método get deve ser chamado apenas uma vez", () async {
      ListinService listinService = ListinService(
        uid: uid,
        firestore: mockFirestore,
      );

      await listinService.getListins();

      verify(mockCollection.get()).called(1);
    });
  });
}
