import 'package:aroundus_app/repositories/order_repository/models/customer_requests.dart';
import 'package:flutter/material.dart';

Widget orderDelivery(CustomerRequests customerRequests) {
  return Wrap(runSpacing: 15, children: [
    Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton(
          isExpanded: true,
          value: 0,
          elevation: 2,
          onChanged: (value) {
            print(value);
          },
          items: List.generate(
              customerRequests.shippingRequest.length,
              (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                        "${customerRequests.shippingRequest[index]["content"]}"),
                  )),
        )),
    TextField(
      decoration: InputDecoration(
        labelText: "추가 요청 사항을 입력해주세요."
      ),
    )
  ]);
}
