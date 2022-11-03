const app = require("express")()
const bp = require("body-parser")
const fetch = require("node-fetch")
const { getPixels } = require("ndarray-pixels")

const auth = "AUTH"
const useRatelimit = true

const rateLimit = require("express-rate-limit").default({
    windowMs: 60 * 1000 * 1,
    max: 10,
    standardHeaders: true,
    legacyHeaders: false,
    statusCode: 429
})

if (useRatelimit) app.use(rateLimit)
app.use(bp.urlencoded({ extended: true }))

app.get("/", async function (req, res) {
    if (req.headers["authorization"] != auth) return res.writeHead(401), res.end()
    if (!req.query.src) return res.writeHead(400), res.end()

    try {
        let fimg = await fetch(req.query.src)
        const content_type = new fetch.Headers(fimg.headers).get("content-type")
        let buffer = Buffer.from(await fimg.arrayBuffer())

        getPixels(buffer, content_type).then(async (pixels) => {
            const width = pixels.shape[0]

            let array = []
            for (let i = 0; i < pixels.data.length; i++) {
                const key = Math.floor(i / 4)
                if (!array[key]) array[key] = []
                array[key].push(pixels.data[i])
            }

            let rows = []
            for (let i = 0; i < array.length; i++) {
                const key = Math.floor(i / width)
                if (!rows[key]) rows[key] = []
                rows[key].push(array[i])
            }

            res.setHeader("content-type", "application/json")
            res.write(JSON.stringify(rows))
            res.end()
        }).catch(err => {
            res.writeHead(500)
            res.end()
            console.error(err)
        })
    } catch (err) {
        res.writeHead(500)
        res.end()
        console.error(err)
    }
})

const listener = app.listen(645, () => {
    console.log(`Listening on ${listener.address().port}`)
})
