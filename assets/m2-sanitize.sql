SET FOREIGN_KEY_CHECKS = 0;

-- Orders

TRUNCATE TABLE `gift_message`;
TRUNCATE TABLE `quote`;
TRUNCATE TABLE `quote_address`;
TRUNCATE TABLE `quote_address_item`;
TRUNCATE TABLE `quote_id_mask`;
TRUNCATE TABLE `quote_item`;
TRUNCATE TABLE `quote_item_option`;
TRUNCATE TABLE `quote_payment`;
TRUNCATE TABLE `quote_shipping_rate`;
TRUNCATE TABLE `reporting_orders`;
TRUNCATE TABLE `sales_bestsellers_aggregated_daily`;
TRUNCATE TABLE `sales_bestsellers_aggregated_monthly`;
TRUNCATE TABLE `sales_bestsellers_aggregated_yearly`;
TRUNCATE TABLE `sales_creditmemo`;
TRUNCATE TABLE `sales_creditmemo_comment`;
TRUNCATE TABLE `sales_creditmemo_grid`;
TRUNCATE TABLE `sales_creditmemo_item`;
TRUNCATE TABLE `sales_invoice`;
TRUNCATE TABLE `sales_invoiced_aggregated`;
TRUNCATE TABLE `sales_invoiced_aggregated_order`;
TRUNCATE TABLE `sales_invoice_comment`;
TRUNCATE TABLE `sales_invoice_grid`;
TRUNCATE TABLE `sales_invoice_item`;
TRUNCATE TABLE `sales_order`;
TRUNCATE TABLE `sales_order_address`;
TRUNCATE TABLE `sales_order_aggregated_created`;
TRUNCATE TABLE `sales_order_aggregated_updated`;
TRUNCATE TABLE `sales_order_grid`;
TRUNCATE TABLE `sales_order_item`;
TRUNCATE TABLE `sales_order_payment`;
TRUNCATE TABLE `sales_order_status_history`;
TRUNCATE TABLE `sales_order_tax`;
TRUNCATE TABLE `sales_order_tax_item`;
TRUNCATE TABLE `sales_payment_transaction`;
TRUNCATE TABLE `sales_refunded_aggregated`;
TRUNCATE TABLE `sales_refunded_aggregated_order`;
TRUNCATE TABLE `sales_shipment`;
TRUNCATE TABLE `sales_shipment_comment`;
TRUNCATE TABLE `sales_shipment_grid`;
TRUNCATE TABLE `sales_shipment_item`;
TRUNCATE TABLE `sales_shipment_track`;
TRUNCATE TABLE `sales_shipping_aggregated`;
TRUNCATE TABLE `sales_shipping_aggregated_order`;
TRUNCATE TABLE `tax_order_aggregated_created`;
TRUNCATE TABLE `tax_order_aggregated_updated`;

-- Customers

TRUNCATE TABLE `customer_address_entity`;
TRUNCATE TABLE `customer_address_entity_datetime`;
TRUNCATE TABLE `customer_address_entity_decimal`;
TRUNCATE TABLE `customer_address_entity_int`;
TRUNCATE TABLE `customer_address_entity_text`;
TRUNCATE TABLE `customer_address_entity_varchar`;
TRUNCATE TABLE `customer_entity`;
TRUNCATE TABLE `customer_entity_datetime`;
TRUNCATE TABLE `customer_entity_decimal`;
TRUNCATE TABLE `customer_entity_int`;
TRUNCATE TABLE `customer_entity_text`;
TRUNCATE TABLE `customer_entity_varchar`;
TRUNCATE TABLE `customer_grid_flat`;
TRUNCATE TABLE `customer_log`;
TRUNCATE TABLE `customer_log`;
TRUNCATE TABLE `customer_visitor`;
TRUNCATE TABLE `persistent_session`;
TRUNCATE TABLE `wishlist`;
TRUNCATE TABLE `wishlist_item`;
TRUNCATE TABLE `wishlist_item_option`;

-- Reviews

TRUNCATE TABLE `review`;
TRUNCATE TABLE `review_detail`;
TRUNCATE TABLE `review_entity_summary`;
TRUNCATE TABLE `review_store`;

SET FOREIGN_KEY_CHECKS = 1;