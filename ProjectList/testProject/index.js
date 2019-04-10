const express = require('express');
const app = express();
const fs = require('fs');


app.get('/ping', (req,res)=>{
    res.status(200).json({
        message:'pong'
    });
});
app.get('/test', (req,res)=>{
    res.json({
        message:'test'
    })
});

app.get('/test2', (req, res)=>{
    res.json({
        message: 'test 2'
    })
});

app.get('/test3', (req, res)=>{
    fs.writeFile("./test", "Hey there!", function(err) {
        if(err) {
            return console.log(err);
        }
    
        console.log("The file was saved!");
    }); 
    res.json({
        message: 'test 3'
    })
});


app.listen(3000 , ()=> console.log(3000) );