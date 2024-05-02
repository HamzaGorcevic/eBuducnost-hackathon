const cheerio = require("cheerio");
const request = require("request");
const jsdom = require("jsdom");
const { JSDOM } = jsdom;

exports.scrape = function scrapeOglasi(posao, callback) {
    request(
        `https://poslovi.infostud.com/oglasi-za-posao-${posao}`,
        (error, response, html) => {
            if (!error && response.statusCode == 200) {
                const dom = new JSDOM(html);
                const scriptTags =
                    dom.window.document.querySelectorAll("script");
                scriptTags.forEach((script) => {
                    if (script.textContent.includes("var ec_data_layer")) {
                        const regex = /var ec_data_layer = (\{.*?\});/s; // s flag for dotall
                        const match = regex.exec(script.textContent);
                        if (match) {
                            const jsonData = match[1];
                            let key = Object.keys(JSON.parse(jsonData))[0];
                            result = JSON.parse(jsonData)[key].ecommerce.items;
                        }
                    }
                });
                callback(null, result);
            } else {
                callback(error, null);
            }
        }
    );
};
