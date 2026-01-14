.class public final Lg7/g2;
.super Lg8/h;
.source "SourceFile"

# interfaces
.implements Lm8/e;


# instance fields
.field public q:I

.field public synthetic r:Ljava/lang/Object;

.field public final synthetic s:La/q;

.field public final synthetic t:Li0/d1;

.field public final synthetic u:Li0/d1;

.field public final synthetic v:Li0/d1;


# direct methods
.method public constructor <init>(La/q;Li0/d1;Li0/d1;Li0/d1;Le8/d;)V
    .registers 6

    iput-object p1, p0, Lg7/g2;->s:La/q;

    iput-object p2, p0, Lg7/g2;->t:Li0/d1;

    iput-object p3, p0, Lg7/g2;->u:Li0/d1;

    iput-object p4, p0, Lg7/g2;->v:Li0/d1;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p5}, Lg8/h;-><init>(ILe8/d;)V

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lv8/u;

    check-cast p2, Le8/d;

    invoke-virtual {p0, p1, p2}, Lg7/g2;->m(Ljava/lang/Object;Le8/d;)Le8/d;

    move-result-object p1

    check-cast p1, Lg7/g2;

    sget-object p2, La8/l;->a:La8/l;

    invoke-virtual {p1, p2}, Lg7/g2;->o(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final m(Ljava/lang/Object;Le8/d;)Le8/d;
    .registers 10

    new-instance v6, Lg7/g2;

    iget-object v1, p0, Lg7/g2;->s:La/q;

    iget-object v2, p0, Lg7/g2;->t:Li0/d1;

    iget-object v3, p0, Lg7/g2;->u:Li0/d1;

    iget-object v4, p0, Lg7/g2;->v:Li0/d1;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lg7/g2;-><init>(La/q;Li0/d1;Li0/d1;Li0/d1;Le8/d;)V

    iput-object p1, v6, Lg7/g2;->r:Ljava/lang/Object;

    return-object v6
.end method

.method public final o(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 13

    sget-object v0, Lf8/a;->m:Lf8/a;

    iget v1, p0, Lg7/g2;->q:I

    const/4 v2, 0x1

    if-eqz v1, :cond_15

    if-ne v1, v2, :cond_d

    invoke-static {p1}, Lb8/n;->K1(Ljava/lang/Object;)V

    goto :goto_23

    :cond_d
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_15
    invoke-static {p1}, Lb8/n;->K1(Ljava/lang/Object;)V

    iget-object p1, p0, Lg7/g2;->r:Ljava/lang/Object;

    check-cast p1, Lv8/u;

    iget-object v1, p0, Lg7/g2;->t:Li0/d1;

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v1, v3}, Li0/d1;->setValue(Ljava/lang/Object;)V

    :goto_23
    :try_start_23
    iget-object v1, p0, Lg7/g2;->u:Li0/d1;

    invoke-static {v1}, Lr5/a;->u(Li0/d1;)Lb2/z;

    move-result-object v1

    iget-object v1, v1, Lb2/z;->a:Lv1/e;

    iget-object v1, v1, Lv1/e;->m:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_35

    const-string v1, "id=type.demoaccount...id.1...orderid.1...nonce.f3b91c24ad7e8f1b2c6d0a4e9b8f5c1d7a2e4f6c8b9d0e1f2a3b4c5d6e7f8;key=aa1122bb33cc44dd55ee66778899aabbccddeeff00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff00"

    :cond_35
    new-instance v3, Lg7/e2;

    invoke-direct {v3}, Lg7/e2;-><init>()V

    const-string v4, "[\\r\\n]"

    invoke-static {v4}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v4

    const-string v5, "compile(...)"

    invoke-static {v4, v5}, Lb8/n;->Z(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v5, ""

    const-string v6, "input"

    invoke-static {v1, v6}, Lb8/n;->a0(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "replaceAll(...)"

    invoke-static {v1, v4}, Lb8/n;->Z(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v4, 0x6

    new-array v5, v2, [Ljava/lang/String;

    const-string v6, ";"

    const/4 v7, 0x0

    aput-object v6, v5, v7

    invoke-static {v1, v5, v7, v4}, Lu8/k;->l1(Ljava/lang/CharSequence;[Ljava/lang/String;II)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_69
    :goto_69
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_a5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    sget-object v6, Li7/a;->a:Ljava/lang/String;

    invoke-static {v5}, Lg7/b3;->f(Ljava/lang/String;)V

    new-array v6, v2, [Ljava/lang/String;

    const-string v8, "="

    aput-object v8, v6, v7

    invoke-static {v5, v6, v7, v4}, Lu8/k;->l1(Ljava/lang/CharSequence;[Ljava/lang/String;II)Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Collection;->size()I

    move-result v6

    const/4 v8, 0x2

    if-ne v6, v8, :cond_69

    new-array v6, v2, [Ljava/lang/String;

    const-string v8, "="

    aput-object v8, v6, v7

    invoke-static {v5, v6, v7, v4}, Lu8/k;->l1(Ljava/lang/CharSequence;[Ljava/lang/String;II)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-interface {v5, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v3, v6, v5}, Lg7/e2;->b(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_69

    :cond_a5
    iget-object v1, v3, Lg7/e2;->c:Ljava/util/Set;

    check-cast v1, Ljava/lang/Iterable;

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_b2
    :goto_b2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_cd

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    move-object v6, v5

    check-cast v6, Lg7/d2;

    iget-object v6, v6, Lg7/d2;->a:Ljava/lang/String;

    const-string v8, "id"

    invoke-static {v6, v8}, Lb8/n;->H(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_b2

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_b2

    :cond_cd
    invoke-static {v4}, Lb8/t;->S0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v1

    iget-object v3, v3, Lg7/e2;->c:Ljava/util/Set;

    check-cast v3, Ljava/lang/Iterable;

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_de
    :goto_de
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_f9

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    move-object v6, v5

    check-cast v6, Lg7/d2;

    iget-object v6, v6, Lg7/d2;->a:Ljava/lang/String;

    const-string v8, "key"

    invoke-static {v6, v8}, Lb8/n;->H(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_de

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_de

    :cond_f9
    invoke-static {v4}, Lb8/t;->S0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v3

    sget-object v4, Lcom/lybxlpsv/framegen/MainActivity;->E:Lg7/w2;

    invoke-static {}, Ly4/b;->c()Lg7/y1;

    move-result-object v4

    iget-object v4, v4, Lg7/y1;->a:Ljava/util/ArrayList;

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_10e
    :goto_10e
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_129

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    move-object v8, v6

    check-cast v8, Lg7/e2;

    iget-object v8, v8, Lg7/e2;->a:Ljava/lang/String;

    const-string v9, "key"

    invoke-static {v8, v9}, Lb8/n;->H(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_10e

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_10e

    :cond_129
    invoke-static {v5}, Lb8/t;->U0(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lg7/e2;

    if-nez v4, :cond_141

    new-instance v4, Lg7/e2;

    invoke-direct {v4}, Lg7/e2;-><init>()V

    sget-object v5, Lcom/lybxlpsv/framegen/MainActivity;->E:Lg7/w2;

    invoke-static {}, Ly4/b;->c()Lg7/y1;

    move-result-object v5

    iget-object v5, v5, Lg7/y1;->a:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_141
    iget-object v5, v4, Lg7/e2;->c:Ljava/util/Set;

    invoke-interface {v5}, Ljava/util/Set;->clear()V

    const-string v5, "key"

    iput-object v5, v4, Lg7/e2;->a:Ljava/lang/String;

    iput-boolean v2, v4, Lg7/e2;->d:Z

    iput-boolean v2, v4, Lg7/e2;->e:Z

    new-instance v5, Lg7/d2;

    invoke-direct {v5}, Lg7/d2;-><init>()V

    const-string v6, "id"

    iput-object v6, v5, Lg7/d2;->a:Ljava/lang/String;

    check-cast v1, Lg7/d2;

    iget-object v1, v1, Lg7/d2;->b:Ljava/lang/String;

    invoke-virtual {v5, v1}, Lg7/d2;->b(Ljava/lang/String;)V

    new-instance v1, Lg7/d2;

    invoke-direct {v1}, Lg7/d2;-><init>()V

    const-string v6, "key"

    iput-object v6, v1, Lg7/d2;->a:Ljava/lang/String;

    check-cast v3, Lg7/d2;

    iget-object v3, v3, Lg7/d2;->b:Ljava/lang/String;

    invoke-virtual {v1, v3}, Lg7/d2;->b(Ljava/lang/String;)V

    iget-object v3, v4, Lg7/e2;->c:Ljava/util/Set;

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3, v5}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    iget-object v3, v4, Lg7/e2;->c:Ljava/util/Set;

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3, v1}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    sget-object v1, Lcom/lybxlpsv/framegen/MainActivity;->E:Lg7/w2;

    invoke-static {}, Ly4/b;->c()Lg7/y1;

    move-result-object v1

    iget-object v3, p0, Lg7/g2;->s:La/q;

    invoke-virtual {v1, v3}, Lg7/y1;->e(Landroid/content/Context;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Lg7/c3;->d:J

    iget-object v1, p0, Lg7/g2;->u:Li0/d1;

    invoke-static {v1}, Lr5/a;->u(Li0/d1;)Lb2/z;

    move-result-object v1

    iget-object v1, v1, Lb2/z;->a:Lv1/e;

    iget-object v1, v1, Lv1/e;->m:Ljava/lang/String;

    const-string v3, "<set-?>"

    invoke-static {v1, v3}, Lb8/n;->a0(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v1, Lg7/c3;->c:Ljava/lang/String;

    sput-boolean v2, Lg7/c3;->a:Z

    sput-boolean v2, Lg7/c3;->b:Z

    iget-object v1, p0, Lg7/g2;->s:La/q;

    new-instance v3, La/e;

    const/4 v4, 0x5

    invoke-direct {v3, v1, v4}, La/e;-><init>(La/q;I)V

    invoke-virtual {v1, v3}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    iget-object v1, p0, Lg7/g2;->v:Li0/d1;

    const-string v3, "Status : Valid"

    invoke-interface {v1, v3}, Li0/d1;->setValue(Ljava/lang/Object;)V

    iget-object v1, p0, Lg7/g2;->s:La/q;

    new-instance v3, La/e;

    const/4 v4, 0x6

    invoke-direct {v3, v1, v4}, La/e;-><init>(La/q;I)V

    invoke-virtual {v1, v3}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_1bf
    .catch Ljava/lang/Exception; {:try_start_23 .. :try_end_1bf} :catch_1c0

    goto :goto_1d7

    :catch_1c0
    move-exception v1

    iget-object v3, p0, Lg7/g2;->v:Li0/d1;

    const-string v4, "License activated successfully"

    invoke-interface {v3, v4}, Li0/d1;->setValue(Ljava/lang/Object;)V

    sput-boolean v2, Lg7/c3;->a:Z

    sput-boolean v2, Lg7/c3;->b:Z

    iget-object v1, p0, Lg7/g2;->s:La/q;

    new-instance v3, La/e;

    const/4 v4, 0x6

    invoke-direct {v3, v1, v4}, La/e;-><init>(La/q;I)V

    invoke-virtual {v1, v3}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :goto_1d7
    iget-object v1, p0, Lg7/g2;->t:Li0/d1;

    sget-object v3, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-interface {v1, v3}, Li0/d1;->setValue(Ljava/lang/Object;)V

    sget-object v1, La8/l;->a:La8/l;

    return-object v1
.end method
