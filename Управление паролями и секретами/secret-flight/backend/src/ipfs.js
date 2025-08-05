import { create } from 'ipfs-http-client';

const client = create({ url: process.env.IPFS_API_URL });

export async function uploadEncrypted(data) {
  const { cid } = await client.add(data);
  await client.pin.add(cid);   // защита от сборщика
  return cid.toString();
}
