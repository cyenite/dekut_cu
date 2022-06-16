import {inject, lifeCycleObserver, LifeCycleObserver} from '@loopback/core';
import {juggler} from '@loopback/repository';

const config = {
  name: 'Firestore',
  connector: 'loopback4-connector-firestore',
  projectId: "paids-da7be",
  clientEmail: "callback@paids-da7be.iam.gserviceaccount.com",
  privateKey: "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyllA9Dr66teTv\nnh/mRs6/ZHKrOvhQxBey3zAeD3c7JWdgHQHzMoHF0gHfxPJ7J94BbCO6pkniZ8dh\nzev6O85+8IwsyzQetoSqdb/NLBlkhSi8JdWCDELuxr+vbvAyRho7MHp0k1mSCPL0\nPlwK9fiO7KhvsglDHceYUI6rtuatC/UX7meIVwTAKFdiAq/tnvWMuFekVnCATIJC\ndH/q+T5W1WBg8Y9iQ5JddbS8ixel8nJq6bhLFfEOGejG69aNxG1CM33eU0FYIiug\nYNLDgm3teJR86Qs+O/HpMZJUDCqsb1pcvTAae7FcvcQrceF24vgxt7IIsWN1vnvZ\nGLp2C4y5AgMBAAECggEAD72o/+C7VfivX6F33VOzaHJBmy8c8P1/uz/p3VRupXN0\nC6gy4k063AVZLfCNkOZgLo7qDUsX6xFLpSbB3HIGDvFD4bTdeLGMuvua9soiyNXl\n08Of8JEFG0fAYIWuPTgpmrr4qCrOs8z/ISEX+s1YZbydUg8Guvg2fgnnsWHzLiBg\na86zBzPIRE/Mm82/hX7TXWJuHjTsro0NzuyUanEqWLqJH/sR+7QeOEB26AYFy8oW\n3zuvZ0eKFuQXZ2a5Gm2ZttJy4Yj9uIWXgBs+AnyVDUAQWjPvNFQHXY0VJVLJ/jxQ\nhfepFrH9yfczGYf2U1UNAVF1WMpGCl17LvqTCflawQKBgQDjaIVzm2ZmRsKHSXSh\nqzYY8nWXXV0qy1HR23+dUgi2uQK8/gUvd+PBT18EmKkNyNQ7J4yyShobDw79uIiD\nT3g1ufaqi0340hTOPEUrkcOMpnxnNSBdgiUvfRqj2a+1oIN2uouTTWvn+Ajy20Se\njH+Es4l6h+fpAVZbog5QIcwziQKBgQDJCmkdf+1inohn/VQB7ajAaEeajpbCat61\ndJEn3Vy31q/3XgouBigoQWZuLJKEzw1j5hKQYwQ9agoKekX28gpa1aGBfiWwsPtk\noM/ueAdyvBbDSIZLj1FiBzP+vyURh9HL//YizSWRxt69NHnCfhqqt+IuzksA88CJ\nfjQBq9LTsQKBgAWLgOWGvoJz6z5dPijLAfCtyMw+DI2Ek6QoU/5EB85cyIJPN1Um\n+Ti3dLup9UVOxk4C8t1ODUDnpxfsrfd1spqsxCT4bJhKlxNISO99CGWfkZz6oKVn\nDP0RcdrY7f3hwhLdDZYz5xOq6pzxV8T97AYSUqHYOoFl9PMbCnpNuKrxAoGAVdpH\nR1zBMDNJRzdMr8IhJYGiymMICKCA2PadomuK08svvDCBomPotEAxkO0h6OtO6ZFv\n7g8K2Xs2LIFI7YsxVtcSMG2BhPIfeTqfcVP6wkmGYwDOsOfUNkujLa/NEa5xrm9x\nWi1HVPibWCtXr/IQS0VZpulb6F0vpMerR+drkhECgYEAs0aZau7poq7CW5ZnZZm+\nGz/V6ijFJf26TRGCulxPKebJ3pA4InNzIxb3Y9W1TEPGQ/+QkbwuYq/Z/+UclILb\nZvz4+5MV1RUDqnOp3g4tZnRzz+/5hhurCh+XRpmeWQR3bJGzTFXedFlnPe/fSZga\n4BABikAW8sOZ1VJVHAe+KZA=\n-----END PRIVATE KEY-----\n",
  databaseName: "paids-da7be"
};

// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
@lifeCycleObserver('datasource')
export class FirestoreDataSource extends juggler.DataSource
  implements LifeCycleObserver {
  static dataSourceName = 'Firestore';
  static readonly defaultConfig = config;

  constructor(
    @inject('datasources.config.Firestore', {optional: true})
    dsConfig: object = config,
  ) {
    super(dsConfig);
  }
}
