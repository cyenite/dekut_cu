import {inject, lifeCycleObserver, LifeCycleObserver} from '@loopback/core';
import {juggler} from '@loopback/repository';

const config = {
  name: 'Firebase',
  connector: 'loopback-connector-realtime-database',
  projectId: "smart-power-sp-default-rtdb",
  clientEmail: "firebase-adminsdk-ht8cr@smart-power-sp.iam.gserviceaccount.com",
  privateKey: "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDlxPdZgNl4/2ic\nrKgvkm4DdmiFtDnU6A3rHYgr6t3PKVXy+OfZv/lk0VKaglgETU9raYGQx6s0wtJD\nFPE7thtm9AED0T6hCN47BvXbeznSQm0aDOHIfJekCm9E/BBHHHD4Q6SHB8q3z3SG\n2P3/JQOlE3vCWvEYAkbwqv5jYL4BnXxuCSNiKV9NheXN4oQN2dewwEkcBUbcioPQ\nHSitSLT1wr52L8O0dmTRUVZxtaP/cXIXEmS6CL+nClhX9XF5MV0d95Rv/XempmlH\nkukyl62JdMWIW/XQShsUnTmdlgXn1g1Rt4MRhUCXaHYuyls/jfZhE6QHVYsV06F8\nkNKtontRAgMBAAECggEAN1ZHayEu3ycGIxurGt/1inRxSmhEOFxWA87WPZuAZbTz\nHAQp1KXZUtheAFPNjmWvL7OWjo+kEl4sZRcNXT/n3BT+jJSPtJlt6kHsIvrLy3GP\nlKNPGmm1XL7dmvvpELNPGt+xp4qvHjNCwXpPu+wGc3Kcjwu3fnyH6M0J3NXPFRSL\nmAMTGi1zwTC88H+YVVFpj9gIhY0+FNpcQF5A5FRbdezc6TOigWgZV1u17q+RwYKC\n/McEoTdqJJdU3axTq4cTn7b51u98cdUbTL+jo86bAKz1rRb3/JbRiWzXdzkLOTeH\nJHxqHWoTXGcDkkpwAghaZ5Oc1KL4iF7KlgCzmpWUJQKBgQD8u+KW3//w7GIcp/W0\nbfykaHJnYzrMGbqO9EDqLZMEmoWxgk1YnXKoxLC3Vve8eQhWUhvJgL0w1iAtGPt4\n0kw3QDsXtKjf56BnKskOKb58F222vxNgRnrx9Nt49qH59El3cjYZstHMrGWgc4T6\nBnM5VTkPewtXmRZ+Ab55Jr9QnQKBgQDovRukxbjazn95kqZk3Oe3ZFJFbZYV08ha\nHqnC/PueDGZVz/hmbRvInJ7p7OTldbmLLKow5y9GGvGU8UZyiqtv/9whSg3iC5fy\nU01hBsKgkA/mTm3C6iiXYeJxszX4dbI3XyEoNDMSwdYp3iiMoVXd2tfYQ2NAxPIQ\nBiwoZwJ1RQKBgHWoSm6OzaotgedxUfOzmIA5l7kF+yN1fuJ6V5YtrVnhTgg7byKn\n+e8T0mkn9aEqf3UgOItwgaMwrD4SeU/gJ1c5cckxc8T5IjWlN4B+co12or8G6VBS\nv33QzjPcLcAdt+4Bn6oLE5zDTXSLEwcK5a11PWE1mSwous3ipffk0AAJAoGBAM2I\nU6VLx1fUDNc8Hx3rx+Y4/j657FUSVljfw2OjLkIBCU62/tLVgDfFuME0p1/MezLh\nGttdDm6G1NmHyYLV21hpR+lOELyTKHikAC2zXqWVE7V7hYsgZwBpPSTT8tGcfupP\nZGSw1Hm4HH2U55Jp1/64iO0/daN5SZvFF7IGZjFRAoGBAIj99RTs2puFTgIy2f4i\nt11cWbSOO9qnlgHPBijRxPJeMZH/URd48dBaw6foJMyEfqkj5Hhemb5ho2Qogz4q\nngWcndB5NKLv20oigJiaWeoI3wEsV/5HeCKghB1sxzVj7xZn+WbU3K+O/oi3wQob\ncsgijAhA8Q2DST0V1zRgNORZ\n-----END PRIVATE KEY-----\n",
  databaseName: "smart-power-sp-default-rtdb"
};

// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
@lifeCycleObserver('datasource')
export class FirebaseDataSource extends juggler.DataSource
  implements LifeCycleObserver {
  static dataSourceName = 'Firebase';
  static readonly defaultConfig = config;

  constructor(
    @inject('datasources.config.Firebase', {optional: true})
    dsConfig: object = config,
  ) {
    super(dsConfig);
  }
}
