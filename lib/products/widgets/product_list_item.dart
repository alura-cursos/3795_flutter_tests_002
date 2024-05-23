import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductListItem extends StatefulWidget {
  final String listinId;
  final Product produto;
  final Function showModal;
  final Function checkboxClick;
  final Function trailClick;

  const ProductListItem({
    super.key,
    required this.listinId,
    required this.produto,
    required this.showModal,
    required this.checkboxClick,
    required this.trailClick,
  });

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.showModal(product: widget.produto);
      },
      leading: Checkbox(
        value: widget.produto.isPurchased,
        onChanged: (value) {
          setState(() {
            widget.produto.isPurchased = !widget.produto.isPurchased;
          });
          widget.checkboxClick(
            product: widget.produto,
            listinId: widget.listinId,
          );
        },
      ),
      trailing: IconButton(
        onPressed: (() {
          widget.trailClick(widget.produto);
        }),
        icon: const Icon(Icons.delete),
      ),
      title: Text(
        (widget.produto.amount == null)
            ? widget.produto.name
            : "${widget.produto.name} (x${widget.produto.amount!.toInt()})",
      ),
      subtitle: Text(
        (widget.produto.price == null)
            ? "Clique para adicionar preço"
            : "R\$ ${widget.produto.price!}",
        key: const Key("subtitle"),
      ),
    );
  }
}
