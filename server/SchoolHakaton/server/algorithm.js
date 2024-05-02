const scraper = require("./scraper");

async function getJobs(predmeti) {
    const ucenikId = predmeti[0].ucenik_id;
    let bestSubjects = new Map();

    for (let i = 0; i < predmeti.length; i++) {
        grades = JSON.parse(predmeti[i].ocene);
        let sum = grades.reduce(
            (accumulator, currentValue) => accumulator + currentValue,
            0
        );
        sum = sum / grades.length;

        let nameAsObj = {
            naziv: predmeti[i].naziv,
            id: predmeti[i].predmet_id,
        };

        bestSubjects.set(nameAsObj, sum);
    }

    let array = Array.from(bestSubjects);
    array.sort((a, b) => b[1] - a[1]);
    array = array.slice(0, 3);

    console.log("ARRAY", array);
    let updatedArray = [];

    await Promise.all(
        array.map(async (subjectData) => {
            let subjectTitle = subjectData[0].naziv;

            try {
                let data = await new Promise((resolve, reject) => {
                    scraper.scrape(subjectTitle, (error, result) => {
                        if (error) {
                            reject(error);
                        } else {
                            resolve(result);
                        }
                    });
                });
                for (let j = 0; j < data.length; j++) {
                    let body = {
                        item_name: data[j].item_name,
                        item_brand: data[j].item_brand,
                        item_category: data[j].item_category,
                        predmet_id: subjectData[0].id,
                        ucenik_id: ucenikId,
                    };

                    updatedArray.push(body);
                }

                // Process the fetched data
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        })
    );

    console.log("updated:", updatedArray);
    await fetch("http://localhost:5000/api/poslovi", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(updatedArray),
    })
        .then((res) => {
            console.log("res=>", res);
        })
        .catch((error) => {
            console.error("Error:", error);
        });

    return updatedArray; // Assuming you don't need to return anything specific
}

module.exports = getJobs;
