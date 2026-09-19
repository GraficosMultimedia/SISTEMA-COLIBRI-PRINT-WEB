USE colibrip_abcsistema;

INSERT INTO cp_whatsapp_templates
    (template_key,name,category,body,active,created_at,updated_at)
VALUES
('quote_sent','Cotización enviada','service','Hola {cliente} 👋\n\nGracias por confiar en {empresa}. Te compartimos la cotización {folio}.\n\n💰 Total cotizado: {total}\n📅 Vigencia: {vigencia}\n\n📄 Ver y descargar tu cotización en PDF:\n{pdf_url}\n\nQuedamos atentos a cualquier duda o ajuste que necesites.\n\nSaludos,\n{empresa}',1,NOW(),NOW()),
('order_confirmed','Pedido confirmado','service','Hola {cliente} 👋\n\nTu pedido {orden} ya fue registrado y comenzamos a trabajar en él.\n\n💰 Total de la orden: {total}\n📅 Fecha compromiso: {fecha_entrega}\n\n🔎 Consulta el avance de tu pedido:\n{seguimiento}\n\nGracias por confiar en {empresa}.',1,NOW(),NOW()),
('design_ready','Diseño listo','service','Hola {cliente} 👋\n\n🎨 El diseño de tu pedido {orden} ya está listo para revisión.\n\nPuedes consultar el avance de tu pedido aquí:\n{seguimiento}\n\nSi necesitas algún ajuste, respóndenos por este mismo medio.\n\n{empresa}',1,NOW(),NOW()),
('design_approval','Aprobación de diseño','service','Hola {cliente} 👋\n\n🎨 El diseño de tu pedido {orden} está listo para aprobación.\n\nPara autorizar la producción, responde a este mensaje con *APROBADO*. Si necesitas cambios, indícanos cuáles para revisarlos contigo.\n\n🔎 Seguimiento del pedido:\n{seguimiento}\n\n{empresa}',1,NOW(),NOW()),
('printing','En impresión','service','Hola {cliente} 👋\n\n🖨️ Tu pedido {orden} ya se encuentra en impresión. Estamos avanzando con tu trabajo.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\n{empresa}',1,NOW(),NOW()),
('in_production','En producción','service','Hola {cliente} 👋\n\n🔧 Tu pedido {orden} ya se encuentra en producción. Nuestro equipo está trabajando en los detalles de tu trabajo.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\n{empresa}',1,NOW(),NOW()),
('quality_review','Control de calidad','service','Hola {cliente} 👋\n\n✅ Tu pedido {orden} está en revisión final de calidad antes de pasar a entrega.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\nTe avisaremos en cuanto esté listo.\n\n{empresa}',1,NOW(),NOW()),
('finished','Trabajo terminado','service','Hola {cliente} 👋\n\n✅ Tu pedido {orden} terminó su proceso de producción.\n\nEstamos preparando la entrega y te avisaremos cuando esté listo para recoger o entregar.\n\n🔎 Seguimiento:\n{seguimiento}\n\n{empresa}',1,NOW(),NOW()),
('ready_delivery','Listo para entrega','service','Hola {cliente} 👋\n\n🚚 ¡Tu pedido {orden} ya está listo para entrega!\n\n📅 Fecha compromiso: {fecha_entrega}\n\n🔎 Consulta los detalles aquí:\n{seguimiento}\n\nGracias por confiar en {empresa}.',1,NOW(),NOW()),
('delivered','Entregado','service','Hola {cliente} 👋\n\n🎉 Tu pedido {orden} ha sido entregado correctamente.\n\nGracias por confiar en {empresa}. Esperamos seguir trabajando contigo.',1,NOW(),NOW()),
('promotion_offer','Promoción comercial','commercial','✨ {label}: {promotion_title}\n\n{promotion_description}\n\n💥 Precio promocional: {promo_price}\n🏷️ Precio normal: {normal_price}\n🎯 Descuento: {discount}\n📅 Vigencia: {vigencia_promocion}\n📦 Disponibilidad: {availability}\n\n🌐 {website}\n\n{empresa}',1,NOW(),NOW())
ON DUPLICATE KEY UPDATE
    name=VALUES(name),
    category=VALUES(category),
    body=VALUES(body),
    active=1,
    updated_at=NOW();
