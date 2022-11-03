const fs = require("fs")
const { getPixels } = require("ndarray-pixels")

const buffer = fs.readFileSync("img.png")
getPixels(buffer, "image/png").then(async (pixels) => {
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

    console.log(`Orginal Res: ${pixels.shape[0]}x${pixels.shape[1]}`)
    console.log(`Formatted Lengths: ${rows[0].length}x${rows.length}`)

    fs.writeFileSync("export.u8d", JSON.stringify(rows))
})
