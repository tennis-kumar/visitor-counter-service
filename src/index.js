import express from 'express';
import { createClient } from 'redis';


const app = express();
const PORT = process.env.PORT || 3000;
const REDIS_URL = process.env.REDIS_URL || 'redis://localhost:6379';

const redisClient = createClient({ url: REDIS_URL });
redisClient.on('error', (err) => console.error('Redis Client Error', err));

await redisClient.connect();
console.log(`Connected to Redis server at ${REDIS_URL}`);


app.use(express.json());

app.get('/visit', async (req, res) => {
    const ip = req.ip || "unknown";
    const key = `visit:${ip}`;

    let visits = await redisClient.get(key);
    visits = visits ? parseInt(visits) + 1 : 1;

    await redisClient.set(key, visits);
    res.json({ ip, visits });
});

app.get('/health', (req, res) => {
    res.send('OK');
});

app.listen( PORT, ()=>{
    console.log(`Server is running on port ${PORT}`);
});