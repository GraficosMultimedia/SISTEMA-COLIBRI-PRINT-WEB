COLIBRI PRINT - TIKTOK CALLBACK
================================

Esta es la primera prueba independiente de WordPress.
No usa MySQL ni Python.

1. Sube esta carpeta a:
   /public_html/tiktok-callback/

2. Abre config.php y coloca:
   TIKTOK_CLIENT_KEY
   TIKTOK_CLIENT_SECRET

3. El Redirect URI registrado en TikTok debe ser exactamente:
   https://colibriprint.com.mx/tiktok-callback/

4. Abre:
   https://colibriprint.com.mx/tiktok-callback/

5. Pulsa "Conectar TikTok".

6. Autoriza la cuenta.

7. Si todo está aprobado/configurado, volverás a la biblioteca y se cargarán
   los videos mediante Display API.

IMPORTANTE
----------
- No compartas el Client Secret.
- La carpeta storage contiene tokens y está protegida por .htaccess.
- Si TikTok devuelve un error de permisos/aprobación, eso significa que la app
  todavía necesita la aprobación/producto correspondiente en TikTok Developer.
