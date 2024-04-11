Flags1 <- list(
  nodes = 128,
  batch_size = 100,
  activation = "relu",
  learning_rate = 0.01,
  epochs = 30
)

model = keras_model_sequential()
model %>%
  layer_dense(units = Flags1$nodes, activation = Flags1$activation) %>%
  layer_dense(units = 32, activation = Flags1$activation) %>%
  layer_dense(units = 3, activation = "softmax")

model %>% compile(optimizer = optimizer_adam(lr = Flags1$learning_rate), loss = 'sparse_categorical_crossentropy', metrics = c('accuracy'))

model %>% fit(
  covid_train_dtm, train_la, epochs = Flags1$epochs, batch_size = Flags1$batch_size, validation_data=list(covid_val_dtm, valid_la)
)
