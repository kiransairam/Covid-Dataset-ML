# Flags <- flags(
#   flag_numeric("nodes", 64),
#   flag_numeric("batch_size", 100),
#   flag_string("activation", "relu"),
#   flag_numeric("learning_rate", 0.01),
#   flag_numeric("epochs", 30),
#   flag_numeric("dropout", 0.2)
#   
# )

Flags <- flags(
  flag_numeric("nodes", 64),
  flag_numeric("batch_size", 100),
  flag_string("activation", "relu"),
  flag_numeric("learning_rate", 0.01),
  flag_numeric("epochs", 30),
  flag_numeric("dropout", 0.2)
)


# model =keras_model_sequential() %>%
#   layer_dense(units = 64, activation = Flags$activation, input_shape = dim(train_bike_x)[2]) %>%
#   layer_dropout(rate = 0.5) %>%
#   layer_dense(units = 1, activation="linear") %>%
#   layer_dropout(rate = 0.3)


model = keras_model_sequential()

model %>%
  layer_dense(units=128, activation="relu", input_shape=dim(train_bike_x)[2])%>%
  layer_dropout(0.2)%>%
  layer_dense(units=128, activation="relu")%>%
  layer_dropout(0.2) %>%
  layer_dense(units=1)




model %>% compile(
  loss = "mse",
  optimizer = "adam",
  metrics = list("mean_absolute_error")
)


model %>% fit(
  as.matrix(train_bike_x),train_bike_y,
  epochs = Flags$epochs,
  batch_size = Flags$batch_size,
  validation_data = list(as.matrix(val_bike_x), val_bike_y)
)