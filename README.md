<div id="top"></div>

<div align="center">
    <strong><h3>Uint8Display</h3></strong>
    <p>A Roblox display system.</p><hr />
</div>

## Setting it up
### > [Server](https://github.com/Astrism/U8D/tree/main/Server)
#### Dependencies
- [NodeJS](https://nodejs.org/dist/v18.12.0/node-v18.12.0-x64.msi)
#### NPM Dependencies (Install using `npm install` in CMD)
- [body-parser](https://www.npmjs.com/package/body-parser)
- [express](https://www.npmjs.com/package/express)
- [express-rate-limit](https://www.npmjs.com/package/express-rate-limit)
- [ndarray-pixels](https://www.npmjs.com/package/ndarray-pixels)
- [node-fetch](https://www.npmjs.com/package/node-fetch/v/2.6.7)

Enable or disable rate limit on line 7, set your authentication key on line 6.
Use `node index.js` to run, install [PM2](https://www.npmjs.com/package/pm2) and run `pm2 start index.js` to keep it online.

### > [Roblox](https://github.com/Astrism/U8D/tree/main/Roblox)

Set the variable "Canvas" to the [Frame](https://create.roblox.com/docs/reference/engine/classes/Frame) you want the image to display on.
Set the variable "SERVER" to the ip or domain you are running the server on.
Set the variable "AUTH" to the authentication you set on the server.
You can change the variable "pixelSize" if you wish to have the pixels bigger or smaller. (offset = pixel size)

❗ Use the function "Begin" to load a png or jpeg onto the Canvas.
You can [JSONDecode](https://create.roblox.com/docs/reference/engine/classes/HttpService#JSONDecode) the `export.u8d` from [Local](https://github.com/Astrism/U8D/tree/main/Local) to load an image without having to setup the server.

*Do not load big images, I recommend under 300-400px in width and size.*
Roblox Luau does not have a built-in memory handler, the server Roblox Studio will crash.

### > [Local](https://github.com/Astrism/U8D/tree/main/Local)
Follow this if you wouldn't setup the server, only supports PNGs.
#### Dependencies
- [NodeJS](https://nodejs.org/dist/v18.12.0/node-v18.12.0-x64.msi)
#### NPM Dependencies (Install using `npm install` in CMD)
- [ndarray-pixels](https://www.npmjs.com/package/ndarray-pixels)

Rename your png `img.png` and start using `node index.js`, `export.u8d` contains the data to use.

### Gallery
<img src="https://cdn.discordapp.com/attachments/1036834806140502027/1037532705757351966/image.png" style="border-radius: 8px;">
<img src="https://cdn.discordapp.com/attachments/1036834806140502027/1037394873634013205/unknown.png" style="border-radius: 8px;">
(Outdated video)
<video>
    <source type="video/mp4" src="https://cdn.discordapp.com/attachments/1036834806140502027/1037117054089711707/RobloxPlayerBeta_g5nXZ5EGi9.mp4">
</video>
